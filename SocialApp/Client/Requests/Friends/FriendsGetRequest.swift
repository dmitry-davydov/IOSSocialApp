//
//  FriendsGetRequest.swift
//  SocialApp
//
//  Created by Дима Давыдов on 06.12.2020.
//

import Foundation
import Alamofire

struct FriendsGetRequest: RequestProtocol {
    enum Order: String {
        case hints
        case random
        case mobile
        case name
    }
    
    enum Fields: String {
        case nickname
        case domain
        case sex
        case bdate
        case city
        case country
        case timezone
        case photo_50
        case photo_100
        case photo_200_orig
        case has_mobile
        case contacts
        case education
        case online
        case relation
        case last_seen
        case status
        case can_write_private_message
        case can_see_all_posts
        case can_post
        case universities
    }
    
    var userId: UserID?
    var order: Order = .hints
    var count: Int?
    var offset: Int = 0
    var fields: [Fields]?
    
    func asParameters() -> Parameters {
        var params: Parameters = [
            "offset": offset.asString(),
            "order": order.rawValue,
        ]
        
        if let userId = userId {
            params["user_id"] = userId.asString()
        }
        
        if let count = count {
            params["count"] = count.asString()
        }
        
        if let fields = fields {
            params["fields"] = fields.map({$0.rawValue}).joined(separator: ",")
        }
        
        return params
    }
    
    func getMethod() -> VKMethod {
        return "friends.get"
    }
}
