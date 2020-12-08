//
//  FriendsDataProvider.swift
//  SocialApp
//
//  Created by Дима Давыдов on 14.10.2020.
//

import Foundation
import RealmSwift

class FriendsDataProvider {
    private let LAST_UPDATED_AT_CACHE_KEY = "FriendsApiEndpointLastUpdatedAt"
    private var endpoint: FriendsApiEndpoint = FriendsApiEndpoint()
    private var lastUpdatedAt: Int {
        get {
            return UserDefaults.standard.integer(forKey: LAST_UPDATED_AT_CACHE_KEY)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: LAST_UPDATED_AT_CACHE_KEY)
        }
    }
    private let apiCacheLifetime: Int = 60 * 5 // 5 минут
    
    static let shared: FriendsDataProvider = FriendsDataProvider()
    
    private init() {
        loadFromApi()
    }
    
    func getData() -> Results<FriendsRealmModel> {
        return RealmService.shared.realm.objects(FriendsRealmModel.self)
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
        
        let request = FriendsGetRequest(userId: nil, order: .name, count: 5000, offset: 0, fields: [.photo_200_orig])
        endpoint.get(request: request, completion: {[weak self] response in
            if let error = response.error {
                debugPrint(error)
                return
            }
            
            guard let response = response.response else {return}
            guard let items = response?.items else {return}
        
            var realmModels: [FriendsRealmModel] = []
            var addedUserIdList: [UserID] = []
            
            for dto in items {
                realmModels.append(FriendsRealmModel(value: [
                    "userId": dto.id,
                    "firstName": dto.firstName,
                    "lastName": dto.lastName,
                    "avatar": dto.photo200orig!,
                    "isDeleted": false,
                ]))
                addedUserIdList.append(dto.id)
            }
            
            if realmModels.count == 0 { return }
            
            do {
                RealmService.shared.realm.beginWrite()
                // выполнить запрос на добавлние
                RealmService.shared.realm.add(realmModels, update: .modified)
                
                // выполнить запрос на установку флага is_deleted = 1 по not in (addedUserIdList)
                let toDeleteModels = RealmService.shared.realm.objects(FriendsRealmModel.self).filter("NOT userId IN %@", addedUserIdList)
                for toDeleteModel in toDeleteModels {
                    toDeleteModel.isDeleted = true
                    RealmService.shared.realm.add(toDeleteModel, update: .modified)
                }
                
                try RealmService.shared.realm.commitWrite()
                
                self?.lastUpdatedAt = Int(Date().timeIntervalSince1970)
                
            } catch (let err) {
                print(err)
            }
        })
    }
}
