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
    
    func getFollowers() {
        let requestUrl = buildUrl(for: Method.followers.rawValue, params: [
            "fields": "photo_100,online,last_seen,screen_name"
        ])
        
        AF.request(requestUrl.url!).responseJSON { response in
            print(response.value)
        }
    }
}
