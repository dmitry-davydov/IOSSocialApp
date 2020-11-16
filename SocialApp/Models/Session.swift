//
//  Session.swift
//  SocialApp
//
//  Created by Дима Давыдов on 16.11.2020.
//

import Foundation

class Session {
    static var shared = Session()
    private init() {}
    
    var token: String = ""
    var id: Int = 0
}
