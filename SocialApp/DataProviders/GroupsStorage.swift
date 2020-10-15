//
//  GroupsDataProvider.swift
//  SocialApp
//
//  Created by Дима Давыдов on 15.10.2020.
//

import Foundation

class GroupsStorage: MemoryDataProvider<Group> {
    static let instance = GroupsStorage()
    
    override init() {
        super.init()
        self.loadFakeData()
    }
    
    private func loadFakeData() {
        for i in 0...100 {
            _ = self.addDataItem(item: Group(gid: UUID.init().uuidString, name: "Group \(i)", image: "https://picsum.photos/200"))
        }
    }
}
