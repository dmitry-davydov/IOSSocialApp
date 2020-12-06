//
//  Wall.swift
//  SocialApp
//
//  Created by Дима Давыдов on 27.11.2020.
//

import Foundation
import Alamofire

class Wall: VKClient {
    
    private enum Methods: VKMethod {
        case wallGet = "wall.get"
    }
    
    func get(request paramters: WallGetRequest, completion: @escaping (VKResponse<WallGetResponse?, Error?>) -> Void) {
        
        let requestUrl = buildUrl(for: Methods.wallGet.rawValue, params: paramters.asParameters())
        
        performRequest(url: requestUrl.url!, decode: WallGetResponse.self, completion: completion)
        
    }
}
