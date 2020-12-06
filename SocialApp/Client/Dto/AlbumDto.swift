//
//  AlbumDto.swift
//  SocialApp
//
//  Created by Дима Давыдов on 25.11.2020.
//

import Foundation

struct AlbumDto: Codable {
    var id: Int
    var thumbId: Int
    var ownerId: UserID
    var title: String
    var description: String
    var created: Int
    var updated: Int
    var size: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case thumbId = "thumb_id"
        case ownerId = "owner_id"
        case title
        case description
        case created
        case updated
        case size
    }
}
