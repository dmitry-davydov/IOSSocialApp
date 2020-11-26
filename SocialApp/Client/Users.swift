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
        
        self
            .session
            .request(requestUrl.url!)
            .responseData { (response) in
                
                switch response.result {
                case .success(_):
                    do {
                        guard let data = response.data else { return }
                        
                        let userResponse = try JSONDecoder().decode(UsersFollowersResponse.self, from: data)
                
                        completion(VKResponse(response: userResponse, error: nil))
                        
                    } catch let DecodingError.keyNotFound(key, context) {
                        completion(VKResponse(response: nil, error: DecodingError.keyNotFound(key, context)))
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let err as NSError {
                        completion(VKResponse(response: nil, error: err))
                        print("Failed to load: \(err.localizedDescription)")
                    }
                case .failure(let err):
                    completion(VKResponse(response: nil, error: err))
                    print("Request error: \(err.localizedDescription)")
                }
            }
        
    }
}
