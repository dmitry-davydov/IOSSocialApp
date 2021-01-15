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
//        if Int(Date().timeIntervalSince1970) - lastUpdatedAt < apiCacheLifetime  {
//            // кеш валиден
//            print("fetch from realm")
//            return
//        }
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 10
        
        let request = FriendsGetRequest(userId: nil, order: .name, count: 5000, offset: 0, fields: [.photo_200_orig])
        
        let vkParseOperation = VkParseOperation<FriendsGetResponse>()
        let realmSaveOperation = FriendsRealmSaveOperation()
        let vkRequestOperation = VkRequestOperation(request: request)
        
        vkParseOperation.addDependency(vkRequestOperation)
        realmSaveOperation.addDependency(vkParseOperation)
        
        queue.addOperation(vkRequestOperation)
        queue.addOperation(vkParseOperation)
        queue.addOperation(realmSaveOperation)
        
//        self.lastUpdatedAt = Int(Date().timeIntervalSince1970)
    }
}
