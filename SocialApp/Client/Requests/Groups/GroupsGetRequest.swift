//
//  GroupsGetRequest.swift
//  SocialApp
//
//  Created by Дима Давыдов on 25.11.2020.
//

import Foundation
import Alamofire

enum GroupsGetRequestFilters: String {
    case advertiser
    case groups
    case publics
    case events
    case hasAddress
}

enum GroupsGetRequestFields: String {
    case city
    case country
    case place
    case description
    case wikiPage = "wiki_page"
    case membersCount = "members_count"
    case counters
    case startDate = "start_date"
    case finishDate = "finish_date"
    case canPost = "can_post"
    case canSeeAllPosts = "can_see_all_posts"
    case activity
    case status
    case contacts
    case links
    case fixedPost = "fixed_post"
    case verified
    case site
    case canCreateTopic = "can_create_topic"
}

struct GroupsGetRequest: RequestProtocol {
    var userId: UserID?
    private var extended: Bool = true
    var filter: [GroupsGetRequestFilters]?
    var fields: [GroupsGetRequestFields]?
    var offset: Int = 0
    var count: Int?
    
    func asParameters() -> Parameters {
        var params: Parameters = [
            "extended": extended ? "1" : "0",
            "offset": offset.asString(),
        ]
        
        if let userId = userId {
            params["user_id"] = userId.asString()
        }
        
        if let filter = filter, filter.count > 0 {
            params["filter"] = filter.map {$0.rawValue}.joined(separator: ",")
        }
        
        if let fields = fields, fields.count > 0 {
            params["fields"] = fields.map {$0.rawValue}.joined(separator: ",")
        }
        
        if let count = count {
            params["count"] = count.asString()
        }
        
        return params
    }
    
    func getMethod() -> VKMethod {
        return "groups.get"
    }
}
