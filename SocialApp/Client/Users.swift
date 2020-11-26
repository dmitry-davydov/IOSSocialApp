//
//  Friends.swift
//  SocialApp
//
//  Created by Дима Давыдов on 22.11.2020.
//

import Foundation
import Alamofire

class Users: VKClient {
    
    private enum Method: VKMethod {
        case followers = "users.getFollowers"
    }
    
    func getFollowers(request paramters: UsersFollowersRequest, completion: @escaping (VKResponse<UsersFollowersResponse?, Error?>) -> Void) {
        let requestUrl = buildUrl(for: Method.followers.rawValue, params: paramters.asParameters())
        
        performRequest(url: requestUrl.url!, decode: UsersFollowersResponse.self, completion: completion)
        
    }
}
