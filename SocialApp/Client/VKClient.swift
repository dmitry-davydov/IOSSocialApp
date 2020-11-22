//
//  Client.swift
//  SocialApp
//
//  Created by Дима Давыдов on 22.11.2020.
//

import Foundation
import Alamofire

typealias VKMethod = String

class VKClient {
    private let version = "5.126"
    
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
}
