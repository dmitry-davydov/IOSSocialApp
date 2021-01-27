//
//  Wall.swift
//  SocialApp
//
//  Created by Дима Давыдов on 27.11.2020.
//

import Foundation
import Alamofire
import PromiseKit

class Wall: VKClient {
    
    private enum Methods: VKMethod {
        case wallGet = "wall.get"
    }
    
    func get(request parameters: WallGetRequest) -> Promise<WallGetResponse> {
        return promise(request: parameters, decode: WallGetResponse.self)
    }
}
