//
//  GroupsDataProvider.swift
//  SocialApp
//
//  Created by Дима Давыдов on 15.10.2020.
//

import Foundation


class GroupsDataProvider {
    let userGroups = UserGroupsStorage.instance
    private let groups = GroupsStorage.instance
    
    static let instance = GroupsDataProvider()

    private var groupsCache: [Group] = []
    
    init() {
        self.filterGlobalCache()
    }
    
    private func filterGlobalCache() {
        let userData = userGroups.getData()
        var gr = groups.getData()
        
        gr.removeAll(where: { (g: Group) in
            userData.contains(where: {(ug: Group) in
                return g.getID() == ug.getID()
            })})
        
        groupsCache = gr
    }
    
    func addUserGroup(_ group: Group) {
        _ = userGroups.addDataItem(item: group)
        self.filterGlobalCache()
    }
    
    func deleteUserGroup(_ group: Group) {
        userGroups.removeItem(id: group.getID())
        self.filterGlobalCache()
    }

    
    func getData() -> [Group] {
        return groupsCache
    }
    
    subscript(groupIndex: Int) -> Group? {
        return groupsCache[groupIndex]
    }
    
//    subscript(userGroupIndex: Int) -> Group {
//        return userGroups[userGroupIndex]
//    }
    
    func getDataCount() -> Int {
        return groupsCache.count
    }
    
}
