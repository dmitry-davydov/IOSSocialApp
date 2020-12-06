//
//  FriendsApiEndpoint.swift
//  SocialApp
//
//  Created by Дима Давыдов on 06.12.2020.
//

import Foundation
import Alamofire

class FriendsApiEndpoint: VKClient {
    
    func get(request paramters: FriendsGetRequest, completion: @escaping (VKResponse<FriendsGetResponse?, Error?>) -> Void) {
        
        let requestUrl = buildUrl(for: paramters.getMethod(), params: paramters.asParameters())
        
        performRequest(url: requestUrl.url!, decode: FriendsGetResponse.self, completion: completion)
    }
}

