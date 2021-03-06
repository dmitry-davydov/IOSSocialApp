//
//  Client.swift
//  SocialApp
//
//  Created by Дима Давыдов on 22.11.2020.
//

import Foundation
import Alamofire
import PromiseKit

typealias VKMethod = String

protocol RequestProtocol {
    func asParameters() -> Parameters
    func getMethod() -> VKMethod
}

struct VKResponse<T, E> {
    var response: T?
    var error: E?
}

extension Session {
    static let custom: Session = {
        var configuration = URLSessionConfiguration.default
        var monitors: [EventMonitor] = []
        #if DEBUG
        let monitor = ClosureEventMonitor()
        
        monitor.requestDidFinish = {request in
            print("======================")
            print("REQUEST: ")
            debugPrint(request)
            print("======================")
        }
        
//        monitor.response = {(request, response) in
//            print("======================")
//            print("RESPONSE: ")
//            debugPrint(response.value)
//            print("======================")
//        }
        
        monitors.append(monitor)
        
        #endif
        
        return Session(configuration: configuration, eventMonitors: monitors)
    }()
}

extension Request {
   public func debugLog() -> Self {
      #if DEBUG
         debugPrint(self)
      #endif
      return self
   }
}

protocol VKClientProtocol {
    func promise<T>(request: RequestProtocol, decode to: T.Type, on: DispatchQoS.QoSClass) -> Promise<T> where T: Decodable
    func buildUrl(for method: VKMethod, params: Parameters?) -> URLComponents
}

class VKClientLogging: VKClientProtocol {
    
    private var client: VKClient
    init(client: VKClient) {
        self.client = client
    }
    
    func buildUrl(for method: VKMethod, params: Parameters?) -> URLComponents {
        print("Build url for method \(method) and params: \(params)")
        return client.buildUrl(for: method, params: params)
    }
    
    func promise<T>(request: RequestProtocol, decode to: T.Type, on: DispatchQoS.QoSClass) -> Promise<T> where T : Decodable {
        print("Performing request with promise")
        print("With request: \(request)")
        print("To decode type: \(to)")
        print("On thead: \(on)")
        return client.promise(request: request, decode: to, on: on)
    }
}

class VKClient: VKClientProtocol {
    
    enum Errors: Error {
        case unexpectedError
    }
    
    private let version = "5.126"
    
    lazy var session = Session.custom
    
    func buildUrl(for method: VKMethod, params: Parameters?) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/\(method)"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: LoginService.shared.accessToken()),
            URLQueryItem(name: "v", value: version),
        ]
        
        if let params = params {
            for (k, v) in params {
                urlComponents.queryItems?.append(URLQueryItem(name: k, value: v as? String))
            }
        }
        
        return urlComponents
    }
    
    func performRequest<T>(url: URL, decode to: T.Type, completion handler: @escaping (VKResponse<T?, Error?>) -> Void) where T: Decodable {
        
        session
            .request(url)
            .debugLog()
            .responseData { (response) in
                
                switch response.result {
                case .success(_):
                    do {
                        guard let data = response.data else { return }
                        let groupsGetResponse = try JSONDecoder().decode(to, from: data)
                        handler(VKResponse(response: groupsGetResponse, error: nil))
                    } catch let DecodingError.keyNotFound(key, context) {
                        handler(VKResponse(response: nil, error: DecodingError.keyNotFound(key, context)))
                    } catch let err as NSError {
                        handler(VKResponse(response: nil, error: err))
                    }
                    
                case .failure(let err):
                    handler(VKResponse(response: nil, error: err))
                }
            }
    }
    
    func performConcurrentRequest<T>(url: URL, decode to: T.Type, completion handler: @escaping (VKResponse<T?, Error?>) -> Void) where T: NotifiableDecodableGroup {
    
        session
            .request(url)
            .debugLog()
            .responseData { (response) in
                
                switch response.result {
                case .success(_):
                    do {
                        guard let data = response.data else { return }
                        
                        let group = DispatchGroup()
                        let queue = DispatchQueue(label: "vkclient.jsondecoder", attributes: .concurrent)
                        let groupsGetResponse = T.init(queue: queue, group: group)
                        try? groupsGetResponse.decode(from: data)
                        if let gr = groupsGetResponse.getNotifyGroup() {
                            gr.notify(queue: DispatchQueue.main) {
                                print("Got notify")
                                
                                handler(VKResponse(response: groupsGetResponse, error: nil))
                            }
                        }
                        
                    } catch let DecodingError.keyNotFound(key, context) {
                        handler(VKResponse(response: nil, error: DecodingError.keyNotFound(key, context)))
                    } catch let err as NSError {
                        handler(VKResponse(response: nil, error: err))
                    }
                    
                case .failure(let err):
                    handler(VKResponse(response: nil, error: err))
                }
            }
        
    }
    
    func promise<T>(request: RequestProtocol, decode to: T.Type, on: DispatchQoS.QoSClass = .userInitiated) -> Promise<T> where T: Decodable {
        
        
        
        return Promise { pr in
            DispatchQueue.global(qos: on).async {[weak self] in
                
                guard let self = self else {
                    pr.reject(Errors.unexpectedError)
                    return
                }
                
                self.session
                    .request(self.buildUrl(for: request.getMethod(), params: request.asParameters()))
                    .debugLog()
                    .responseData { (response) in
                        switch response.result {
                        case .success(_):
                            do {
                                guard let data = response.data else { return }
                                let decodedResponse = try JSONDecoder().decode(to, from: data)
                                pr.resolve(decodedResponse, nil)
                            } catch let DecodingError.keyNotFound(key, context) {
                                pr.reject(DecodingError.keyNotFound(key, context))
                            } catch let err {
                                print("Catched in decoding" + err.localizedDescription)
                                pr.reject(err)
                            }
                        case .failure(let err):
                            fatalError(err.localizedDescription)
                            pr.reject(err)
                        }
                    }
            }
            
        }
    }
}
