//
//  GroupsGetResponse.swift
//  SocialApp
//
//  Created by Дима Давыдов on 25.11.2020.
//

import Foundation

struct GroupsGetResponse: Decodable {
    var count: Int
    var items: [GroupDto]
    
    enum CodingKeys: String, CodingKey {
        case count
        case items
        case response
    }
    
    init(from decoder: Decoder) throws {
        let main = try decoder.container(keyedBy: CodingKeys.self)
        let response = try main.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        
        self.count = try response.decode(Int.self, forKey: .count)
        self.items = try response.decode([GroupDto].self, forKey: .items)
    }
}
