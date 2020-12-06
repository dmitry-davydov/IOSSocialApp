//
//  GroupsDataProvider.swift
//  SocialApp
//
//  Created by Дима Давыдов on 15.10.2020.
//

import Foundation
import RealmSwift

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
    
    private init() {
        loadFromApi()
    }
    
    func getData() -> Results<GroupsRealmModel> {
        
        if lastUpdatedAt == 0 {
            loadFromApi()
        }
        
        return RealmService.shared.realm.objects(GroupsRealmModel.self)
    }
    func getCount() -> Int {
        return self.getData().count
    }
    
    private func loadFromApi() {
        if Int(Date().timeIntervalSince1970) - lastUpdatedAt < apiCacheLifetime  {
            // кеш валиден
            print("fetch from realm")
            return
        }
        
        endpoint.get(request: GroupsGetRequest(), completion: {[weak self] response in
            if let error = response.error {
                debugPrint(error)
                return
            }
            
            guard let response = response.response else {return}
            guard let items = response?.items else {return}
        
            RealmService.shared.realm.beginWrite()
            // удалить старый кеш
            let oldObjects = RealmService.shared.realm.objects(GroupsRealmModel.self)
            RealmService.shared.realm.delete(oldObjects)
            
            do {
                
                for dto in items {
                    RealmService.shared.realm.add(GroupsRealmModel(value: [
                        "groupId": dto.id,
                        "name": dto.name,
                        "avatar": dto.photo200,
                    ]))
                }

                try RealmService.shared.realm.commitWrite()
                
                self?.lastUpdatedAt = Int(Date().timeIntervalSince1970)
                
            } catch (let err) {
                print(err)
            }
        })
    }
    
}
