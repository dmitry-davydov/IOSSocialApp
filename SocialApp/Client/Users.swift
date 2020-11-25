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
        
        
        self
            .session
            .request(requestUrl.url!)
            .responseData { (response) in
                
                switch response.result {
                case .success(_):
                    do {
                        
                        print(response.data)
                        
                        guard let data = response.data else {
                            print("tut")
                            return
                            
                        }
                        
                        let userResponse = try JSONDecoder().decode(UserSubscriptionsResonse.self, from: data)
                        
                        debugPrint(userResponse)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                        
                    } catch let err as NSError {
                        debugPrint(err)
                        print("Failed to load: \(err.localizedDescription)")
                    }
                case .failure(let err):
                    print("Request error: \(err.localizedDescription)")
                }
            }
    }
}
