//
//  PhotosGetAlbumsResponse.swift
//  SocialApp
//
//  Created by Дима Давыдов on 31.01.2021.
//

import Foundation

typealias AlbumId = Int

struct PhotoAlbum: Decodable {
    var id: AlbumId
    var ownerId: UserID
    var title: String
    var description: String?
    var created: TimeInterval?
    var size: Int
    var sizes: [PhotoSize]
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case title
        case description
        case created
        case size
        case sizes
    }
}

struct PhotosGetAlbumsReponse: Decodable {

    var count: Int = 0
    var items: [PhotoAlbum] = []
    
    private enum CodingKeys: String, CodingKey {
        case count
        case items
        case response
    }
    
    init(from decoder: Decoder) throws {
        let main = try decoder.container(keyedBy: CodingKeys.self)
        let response = try main.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        
        self.count = try response.decode(Int.self, forKey: .count)
        self.items = try response.decode([PhotoAlbum].self, forKey: .items)
    }
}
