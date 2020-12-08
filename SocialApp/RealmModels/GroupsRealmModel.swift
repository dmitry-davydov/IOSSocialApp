//
//  GroupsRealmModel.swift
//  SocialApp
//
//  Created by Дима Давыдов on 06.12.2020.
//

import Foundation
import RealmSwift

class GroupsRealmModel: Object {
    @objc dynamic var groupId: UserID = 0
    @objc dynamic var name: String = ""
    @objc dynamic var avatar: String = ""
    
    override class func primaryKey() -> String? {
        return "groupId"
    }
}
