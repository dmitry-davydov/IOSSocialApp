//
//  UsersFollowersResponse.swift
//  SocialApp
//
//  Created by Дима Давыдов on 26.11.2020.
//

import Foundation

struct UsersFollowersResponse: Decodable {
    var count: Int
    var items: [UserDto]
    
    enum CodingKeys: String, CodingKey {
        case response
        case count
        case items
    }
    
    init(from decoder: Decoder) throws {
        let main = try decoder.container(keyedBy: CodingKeys.self)
        let response = try main.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        
        self.count = try response.decode(Int.self, forKey: .count)
        self.items = try response.decode([UserDto].self, forKey: .items)
    }
}
