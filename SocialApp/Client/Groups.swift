//
//  Groups.swift
//  SocialApp
//
//  Created by Дима Давыдов on 22.11.2020.
//

import Foundation
import Alamofire

enum GroupType: String {
    case group, page, event
}



class Groups: VKClient {
    
    private enum Methods: VKMethod {
        case get = "groups.get"
        case search = "groups.search"
    }
    
    func currentUserGroups() {
        let requestUrl = buildUrl(for: Methods.get.rawValue, params: [
            "extended": "1",
            "fields": "id,name,type,photo_100"
        ])
        
        AF.request(requestUrl.url!).responseJSON {response in
            print(response.value)
        }
    }
    
    func search(by name: String, type: GroupType) {
        let requestUrl = buildUrl(for: Methods.search.rawValue, params: [
            "q": name,
            "type": type.rawValue,
        ])
        
        AF.request(requestUrl.url!).responseJSON {response in
            print(response.value)
        }
    }
    
    func get(request parameters: GroupsGetRequest, completion: @escaping (VKResponse<GroupsGetResponse?, Error?>) -> Void) {
        let requestUrl = buildUrl(for: Methods.get.rawValue, params: parameters.asParameters())
        
        self
            .session
            .request(requestUrl.url!)
            .responseData { (response) in
                
                switch response.result {
                case .success(_):
                    do {
                        guard let data = response.data else { return }
                        let groupsGetResponse = try JSONDecoder().decode(GroupsGetResponse.self, from: data)
                        completion(VKResponse(response: groupsGetResponse, error: nil))
                    } catch let DecodingError.keyNotFound(key, context) {
                        completion(VKResponse(response: nil, error: DecodingError.keyNotFound(key, context)))
                    } catch let err as NSError {
                        completion(VKResponse(response: nil, error: err))
                    }
                    
                case .failure(let err):
                    completion(VKResponse(response: nil, error: err))
                }
            }
    }
}

