//
//  RealmService.swift
//  SocialApp
//
//  Created by Дима Давыдов on 06.12.2020.
//

import Foundation
import RealmSwift

class RealmService {
    static var shared = RealmService()
    
    var realm: Realm
    
    private init() {
        realm = try! Realm()
        
        #if DEBUG
        print("RealmFile: \(realm.configuration.fileURL)")
        #endif
    }
}
