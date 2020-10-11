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
    
    func performLogin(username: String, password: String) ->Bool {
        self.user = false
        
        self.attempts += 1
        
        if attempts % 2 == 0 {
            self.user = true
        }
        
        sleep(1)
        
        return user
    }
}
