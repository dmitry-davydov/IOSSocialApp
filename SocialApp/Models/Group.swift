//
//  Group.swift
//  SocialApp
//
//  Created by Дима Давыдов on 04.10.2020.
//

import Foundation

struct Group: IDProtocol {
    var gid: String
    var name: String
    var image: String
    
    func getImageURL() -> URL {
        return URL.init(string: self.image)!
    }
    
    func getID() -> String {
        return gid
    }
}
