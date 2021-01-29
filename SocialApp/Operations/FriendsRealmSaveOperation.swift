//
//  RealmSaveOperation.swift
//  SocialApp
//
//  Created by Дима Давыдов on 13.01.2021.
//

import Foundation
import RealmSwift

class FriendsRealmSaveOperation: AsyncOperation {
    
    override func main() {
        
        guard let vkParseOperation = self.dependencies.first as? VkParseOperation<FriendsGetResponse>,
              let response = vkParseOperation.response,
              let friendsGetResponse = response.response,
              let userDtoList = friendsGetResponse?.items else {
            state = .finished
            return
        }
        
        var realmModels: [FriendsRealmModel] = []
        var addedUserIdList: [UserID] = []
        
        for dto in userDtoList {
            realmModels.append(FriendsRealmModel(value: [
                "userId": dto.id,
                "firstName": dto.firstName,
                "lastName": dto.lastName,
                "avatar": dto.photo200orig!,
                "isDeleted": false,
            ]))
            addedUserIdList.append(dto.id)
        }
        
        if realmModels.count == 0 {
            state = .finished
            return
        }

        DispatchQueue.main.async {
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
                
                self.state = .finished
                
            } catch (let err) {
                print(err)
                self.state = .finished
            }
        }
    }
}
