//
//  Session.swift
//  SocialApp
//
//  Created by Дима Давыдов on 16.11.2020.
//

import Foundation

class UserSession {
    var token: String = ""
    var userId: String = ""
    
    func getUserIdAsUserId() -> UserID {
        return UserID(userId)!
    }
}
