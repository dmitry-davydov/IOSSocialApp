//
//  NewsFeedApiEndpoint.swift
//  SocialApp
//
//  Created by Дима Давыдов on 01.01.2021.
//

import Foundation
import Alamofire

class NewsFeedApiEndpiont: VKClient {
    func get(request parameters: NewsFeedGetRequest, completion: @escaping (VKResponse<NewsFeedGetResponse?, Error?>) -> Void) {
        let requestUrl = buildUrl(for: parameters.getMethod(), params: parameters.asParameters())
        
        performConcurrentRequest(url: requestUrl.url!, decode: NewsFeedGetResponse.self, completion: completion)
    }
}
