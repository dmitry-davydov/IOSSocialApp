//
//  PhotosGetByIdRequest.swift
//  SocialApp
//
//  Created by Дима Давыдов on 25.11.2020.
//

import Foundation
import Alamofire

struct PhotosGetByIdRequest: RequestProtocol {
    var photos: [String] = []
    var extended: Bool = false
    var photoSizes: Bool = false
    
    func asParameters() -> Parameters {
        let params: Parameters = [
            "photos": photos.joined(separator: ","),
            "extended": extended ? "1" : "0",
            "photo_sizes": photoSizes ? "1" : "0",
        ]
        
        return params
    }
    
    func getMethod() -> VKMethod {
        return "photos.getById"
    }
}
