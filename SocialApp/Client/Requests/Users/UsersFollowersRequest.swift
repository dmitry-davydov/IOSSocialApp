//
//  UsersFollowersRequest.swift
//  SocialApp
//
//  Created by Дима Давыдов on 26.11.2020.
//

import Foundation
import Alamofire

enum UsersFollowersRequestFields: String {
    case photoId = "photo_id"
    case verified, sex, bdate, city, country
    case homeTown = "home_town"
    case hasPhoto = "has_photo"
    case photo50 = "photo_50"
    case photo100 = "photo_100"
    case photo200orig = "photo_200_orig"
    case photo200 = "photo_200"
    case photo400orig = "photo_400_orig"
    case photoMax = "photo_max"
    case photoMaxOrig = "photo_max_orig"
    case online, lists, domain
    case hasMobile = "has_mobile"
    case contacts, site, education, universities, schools, status
    case lastSeen = "last_seen"
    case followersCount = "followers_count"
    case commonCount = "common_count"
    case occupation, nickname, relatives, relation, personal, connections, exports
    case wallComments = "wall_comments"
    case activities, interests, music, movies, tv, books, games, about, quotes
    case canPost = "can_post"
    case canSeeAllPosts = "can_see_all_posts"
    case canSeeAudio = "can_see_audio"
    case canWritePrivateMessage = "can_write_private_message"
    case canSendFriendRequest = "can_send_friend_request"
    case ifFavorite = "is_favorite"
    case isHiddenFromFeed = "is_hidden_from_feed"
    case timezone
    case screenName = "screen_name"
    case maidenName = "maiden_name"
    case cropPhoto = "crop_photo"
    case isFriend = "is_friend"
    case friendStatus = "friend_status"
    case career, military, blacklisted
    case blacklistedByMe = "blacklisted_by_me"
}

enum UsersFollowersRequestNameCase: String {
    case nom
    case gen
    case dat
    case acc
    case ins
    case abl
}

struct UsersFollowersRequest: RequestProtocol {
    var userId: UserID?
    var offset: Int = 0
    var count: Int?
    var fields: [UsersFollowersRequestFields]?
    var nameCase: UsersFollowersRequestNameCase = .nom
    
    func asParameters() -> Parameters {
        var parameters: Parameters = [
            "offset": offset.asString(),
            "name_case": nameCase.rawValue,
        ]
        
        if let userId = userId {
            parameters["user_id"] = userId.asString()
        }
        
        if let fields = fields, fields.count > 0 {
            parameters["fields"] = fields.map({$0.rawValue}).joined(separator: ",")
        }
        
        return parameters
    }
}
