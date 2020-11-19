//
//  LoginService.swift
//  SocialApp
//
//  Created by Дима Давыдов on 30.09.2020.
//

import Foundation

class LoginService {
    private var user: Bool = false
    private var attempts: Int = 0
    
    func isLoggedIn() -> Bool {
        return user
    }
    
    func performLogin(username: String, password: String) -> Bool {
        self.user = username == "1" && password == "1"
        sleep(2)
        return user
    }
}
