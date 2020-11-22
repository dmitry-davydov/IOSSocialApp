//
//  Photos.swift
//  SocialApp
//
//  Created by Дима Давыдов on 22.11.2020.
//

import Foundation
import Alamofire

class Photos: VKClient {
    
    private enum Methods: VKMethod {
        case get = "photos.get"
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
}
