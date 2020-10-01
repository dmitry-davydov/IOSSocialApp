//
//  LoginService.swift
//  SocialApp
//
//  Created by Дима Давыдов on 30.09.2020.
//

import Foundation

class LoginService {
    private var user: Bool = false
    
    func isLoggedIn() -> Bool {
        return user
    }
    
    func performLogin(user: String, password: String) ->Bool {
        print("Perform Login - username: \(user):\(password)")
        sleep(1)
        self.user = true
        
        return true
    }
}
