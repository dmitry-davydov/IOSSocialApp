//
//  Client.swift
//  SocialApp
//
//  Created by Дима Давыдов on 22.11.2020.
//

import Foundation
import Alamofire

typealias VKMethod = String

protocol RequestProtocol {
    func asParameters() -> Parameters
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

class VKClient {
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
}
