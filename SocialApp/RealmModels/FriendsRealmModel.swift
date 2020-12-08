//
//  FriendsRealmModel.swift
//  SocialApp
//
//  Created by Дима Давыдов on 06.12.2020.
//

import Foundation
import RealmSwift

class FriendsRealmModel: Object {
    @objc dynamic var userId: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var avatar: String = ""
    @objc dynamic var isDeleted: Bool = false
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    override class func primaryKey() -> String? {
        return "userId"
    }
    
    override class func indexedProperties() -> [String] {
        return ["firstName", "lastName"]
    }
}
