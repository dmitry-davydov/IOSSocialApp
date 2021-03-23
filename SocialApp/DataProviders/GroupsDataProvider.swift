//
//  GroupsDataProvider.swift
//  SocialApp
//
//  Created by Дима Давыдов on 15.10.2020.
//

import Foundation
import RealmSwift
import Firebase
import PromiseKit

class GroupsDataProvider {
    private let LAST_UPDATED_AT_CACHE_KEY = "UserGroupsApiEndpointLastUpdatedAt"
    private var endpoint: GroupsApiEndpoint = GroupsApiEndpoint()
    private var lastUpdatedAt: Int {
        get {
            return UserDefaults.standard.integer(forKey: LAST_UPDATED_AT_CACHE_KEY)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: LAST_UPDATED_AT_CACHE_KEY)
        }
    }
    private let apiCacheLifetime: Int = 60 * 5 // 5 минут
    
    static let shared: GroupsDataProvider = GroupsDataProvider()
    
    func getData() -> Promise<Results<GroupsRealmModel>> {
        
        if let promise = loadFromApi() {
            return promise
                .then { (_) -> Promise<Results<GroupsRealmModel>> in
                    return Promise.value(RealmService.shared.realm.objects(GroupsRealmModel.self))
                }
        }
        
        return Promise.value(RealmService.shared.realm.objects(GroupsRealmModel.self))
    }
    
    func getCount() -> Promise<Int> {
        return getData()
            .then { (realmResult) -> Promise<Int> in
                return Promise.value(realmResult.count)
            }
    }
    
    private func saveToRealm(itemList: [GroupDto]) {
        RealmService.shared.realm.beginWrite()
        // удалить старый кеш
        let oldObjects = RealmService.shared.realm.objects(GroupsRealmModel.self)
        RealmService.shared.realm.delete(oldObjects)
        
        do {
            
            for dto in itemList {
                RealmService.shared.realm.add(GroupsRealmModel(value: [
                    "groupId": dto.id,
                    "name": dto.name,
                    "avatar": dto.photo200,
                ]))
            }

            try RealmService.shared.realm.commitWrite()
            
            self.lastUpdatedAt = Int(Date().timeIntervalSince1970)
            
        } catch (let err) {
            print(err)
        }
        
        // сохранить в firebase
        let db = Firestore.firestore()
        
        var filestoreData = [String: Any]()
        for dto in itemList {
            filestoreData[dto.id.asString()] = dto.toFilestore()
        }
        
        db.collection("users").document(LoginService.shared.userId()).setData(filestoreData, merge: true) {err in
            if let err = err {
                print(err.localizedDescription)
            } else { print("data saved") }
        }
    }
    
    private func loadFromApi() -> Promise<GroupsGetResponse>? {
        if Int(Date().timeIntervalSince1970) - lastUpdatedAt < apiCacheLifetime  {
            // кеш валиден
            print("fetch from realm")
            return nil
        }
        
        return endpoint
            .get(request: GroupsGetRequest())
            .get(on: .main, { [weak self] (response) in
                self?.saveToRealm(itemList: response.items)
            })
    }
    
}
