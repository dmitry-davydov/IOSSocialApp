//
//  PhotosGetByAlbumIdRequest.swift
//  SocialApp
//
//  Created by Дима Давыдов on 31.01.2021.
//

import Foundation
import Alamofire

struct PhotosGetByAlbumIdRequest: RequestProtocol {
    var ownerId: UserID
    var albumId: AlbumId
    var extended: Bool = false
    var photoSizes: Bool = true
    var offset: Int = 0
    var count: Int = 50
    
    func asParameters() -> Parameters {
        let params: Parameters = [
            "owner_id": ownerId.asString(),
            "album_id": albumId.asString(),
            "extended": extended ? "1" : "0",
            "photo_sizes": photoSizes ? "1" : "0",
            "offset": offset.asString(),
            "count": count.asString()
        ]
        
        return params
    }
    
    func getMethod() -> VKMethod {
        return VKMethod("photos.get")
    }
}
