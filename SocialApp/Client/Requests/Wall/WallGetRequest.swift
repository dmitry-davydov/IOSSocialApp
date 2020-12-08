//
//  WallGetRequest.swift
//  SocialApp
//
//  Created by Дима Давыдов on 27.11.2020.
//

import Foundation
import Alamofire

enum WallGetRequestFilter: String {
    case suggests
    case postponed
    case owner
    case others
    case all
}


struct WallGetRequest: RequestProtocol {
    var ownerId: UserID?
    var domain: String?
    var offset: Int = 0
    var count: Int?
    var filter: WallGetRequestFilter = .all
    var extended: Bool = false
    // var fields
    
    func asParameters() -> Parameters {
        var params: Parameters = [
            "extended": extended ? "1" : "0",
            "offset": offset.asString(),
            "filter": filter.rawValue,
        ]
        
        if let ownerId = ownerId {
            params["owner_id"] = ownerId.asString()
        }
        
        if let domain = domain {
            params["domain"] = domain
        }
        
        if let count = count {
            params["count"] = count.asString()
        }
        
        return params
    }
    
    func getMethod() -> VKMethod {
        return "wall.get"
    }
}
