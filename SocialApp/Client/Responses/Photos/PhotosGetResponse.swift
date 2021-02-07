//
//  PhotosGetResponse.swift
//  SocialApp
//
//  Created by Дима Давыдов on 31.01.2021.
//

import Foundation

struct PhotosGetResponse: Decodable {
    var count: Int
    var items: [PhotoDto]
    
    private enum CodingKeys: String, CodingKey {
        case count
        case items
        case response
    }
    
    init(from decoder: Decoder) throws {
        let main = try decoder.container(keyedBy: CodingKeys.self)
        let response = try main.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        
        self.count = try response.decode(Int.self, forKey: .count)
        self.items = try response.decode([PhotoDto].self, forKey: .items)
    }
}
