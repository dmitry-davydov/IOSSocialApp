//
//  WallGetResponse.swift
//  SocialApp
//
//  Created by Дима Давыдов on 27.11.2020.
//

import Foundation

extension Array where Element == GroupDto {
    func findBy(ownerId: Int) -> GroupDto? {
        for item in self {
            if ownerId.magnitude != item.id {
                continue
            }
            
            return item
        }
        
        return nil
    }
}

struct WallGetResponse: Decodable {
    var count: Int
    var items: [GroupItemDto]
    var groups: [GroupDto]
    
    enum CodingKeys: String, CodingKey {
        case response
        case items
        case count
        case groups
    }
    
    init(from decoder: Decoder) throws {
        let main = try decoder.container(keyedBy: CodingKeys.self)
        let response = try main.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        
        self.count = try response.decode(Int.self, forKey: .count)
        self.items = try response.decode([GroupItemDto].self, forKey: .items)
        self.groups = try response.decode([GroupDto].self, forKey: .groups)
    }
}
