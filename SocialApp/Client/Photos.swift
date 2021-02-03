//
//  Photos.swift
//  SocialApp
//
//  Created by Дима Давыдов on 22.11.2020.
//

import Foundation
import Alamofire
import PromiseKit

class Photos: VKClient {
    
    private enum Methods: VKMethod {
        case get = "photos.get"
        case getAlbums = "photos.getAlbums"
        case getById = "photos.getById"
    }
    
    func getWallPhotos() {
        let requestUrl = buildUrl(for: Methods.get.rawValue, params: [
            "album_id": "wall",
            "extended": "1"
        ])
        
        AF.request(requestUrl.url!).responseJSON {response in
            print(response.value)
        }
    }
    
    func getPhotosInAlbum(request parameters: PhotosGetByAlbumIdRequest) -> Promise<PhotosGetResponse> {
        return promise(request: parameters, decode: PhotosGetResponse.self)
    }
    
    func getAlbums(request parameters: PhotosGetAlbumsRequest) -> Promise<PhotosGetAlbumsReponse> {
        return promise(request: parameters, decode: PhotosGetAlbumsReponse.self)
    }
    
    func getById(request parameters: PhotosGetByIdRequest) {
        let requestUrl = buildUrl(for: Methods.getAlbums.rawValue, params: parameters.asParameters())
        
        AF.request(requestUrl.url!).responseJSON {response in
            print(response.value)
        }
    }
}
