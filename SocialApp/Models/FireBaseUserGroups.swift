//
//  FireBaseUserGroups.swift
//  SocialApp
//
//  Created by Дима Давыдов on 13.12.2020.
//

import Foundation
import FirebaseDatabase


class FireBaseUserGroups {
    let ref: DatabaseReference?
    let id: String
    let name: String
    let imageUrl: String

    init(id: String, name: String, imageUrl: String) {
        self.ref = nil
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let id = value["id"] as? String,
            let name = value["name"] as? String,
            let imageUrl = value["imageUrl"] as? String else {
            return nil
        }
        
        self.ref = snapshot.ref
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "imageUrl": imageUrl,
        ]
    }
}
