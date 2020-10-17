//
//  FriendsDataProvider.swift
//  SocialApp
//
//  Created by Дима Давыдов on 14.10.2020.
//

import Foundation


class FriendsDataProvider: MemoryDataProvider<User> {
    static let instance = FriendsDataProvider()
    
    override init() {
        super.init()
        self.loadFakeData()
    }
    
    private func loadFakeData() {
        _ = self
            .addDataItem(item: User(uid: UUID.init().uuidString, name: "User1", image: "https://picsum.photos/200"))
            .addDataItem(item: User(uid: UUID.init().uuidString, name: "User2", image: "https://picsum.photos/200"))
            .addDataItem(item: User(uid: UUID.init().uuidString, name: "User3", image: "https://picsum.photos/200"))
            .addDataItem(item: User(uid: UUID.init().uuidString, name: "User4", image: "https://picsum.photos/200"))
            .addDataItem(item: User(uid: UUID.init().uuidString, name: "User5", image: "https://picsum.photos/200"))
    }
}
