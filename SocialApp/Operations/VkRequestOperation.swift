//
//  VkRequestOperation.swift
//  SocialApp
//
//  Created by Дима Давыдов on 13.01.2021.
//

import Foundation
import Alamofire

class VkRequestOperation: AsyncOperation {
    
    var request: RequestProtocol
    var result: AFDataResponse<Data>?
    
    private let version = "5.126"
    
    override var isAsynchronous: Bool {
        return true
    }
    
    init(request: RequestProtocol) {
        self.request = request
        super.init()
    }
    
    private func buildUrl(for method: VKMethod, params: Parameters?) -> URLComponents {
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
    
    override func main() {
        print("Enter main VkRequestOperation")
        guard let url = buildUrl(for: request.getMethod(), params: request.asParameters()).url else { return }
        
        Session.custom
            .request(url)
            .debugLog()
            .responseData { [weak self] (response) in
                print("done request")
                self?.result = response
                self?.state = .finished
            }
    }
}
