//
//  PhotosGetAlbumsRequest.swift
//  SocialApp
//
//  Created by Дима Давыдов on 25.11.2020.
//

import Foundation
import Alamofire

struct PhotosGetAlbumsRequest: RequestProtocol {
    var ownerId: UserID?
    var albumIds: [Int] = []
    var offset: Int = 0
    var needSystem: Bool = false
    var needCovers: Bool = true
    var photoSizes: Bool = true
    
    func asParameters() -> Parameters {
        var params: Parameters = [
            "need_system": needSystem ? "1" : "0",
            "need_covers": needCovers ? "1" : "0",
            "photo_sizes": photoSizes ? "1" : "0",
        ]
        
        if let ownerId = ownerId {
            params["owner_id"] = ownerId
        }
        
        if albumIds.count > 0 {
            params["album_ids"] = albumIds.map {"\($0)"}.joined(separator: ",")
        }
        
        if offset > 0 {
            params["offset"] = offset
        }
        
        return params
    }
    
    func getMethod() -> VKMethod {
        return "photos.getAlbums"
    }
}
