//
//  User.swift
//  SocialApp
//
//  Created by Дима Давыдов on 04.10.2020.
//

import Foundation

struct User: IDProtocol {
    var uid: String
    var name: String
    var image: String
    
    func getImageURL() -> URL {
        return URL.init(string: self.image)!
    }
    
    func getID() -> String {
        return uid
    }
}
