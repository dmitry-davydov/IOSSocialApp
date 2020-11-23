//
//  LoginService.swift
//  SocialApp
//
//  Created by Дима Давыдов on 30.09.2020.
//

import Foundation


class LoginService {
    static var shared = LoginService()
    private init(){}
    
    enum Scope: Int {
        case friends = 2
        case photos = 4
        case wall = 8192
        case groups = 262144
    }
    
    private let clientId = 7672440
    private let scope = [Scope.friends.rawValue, Scope.groups.rawValue, Scope.wall.rawValue, Scope.groups.rawValue].reduce(0, +)
    
    private let redirectUrl = "https://oauth.vk.com/blank.html"
    private var session = UserSession()
    
    func oAuthLoginUrl() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: clientId.asString()),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: redirectUrl),
            URLQueryItem(name: "scope", value: scope.asString()),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.126")
        ]
        
        return urlComponents
    }
    
    func setAuthToken(_ token: String) {
        self.session.token = token
    }
    
    func isLoggedIn() -> Bool {
        return session.token != ""
    }
    
    func accessToken() -> String {
        return session.token
    }
}
