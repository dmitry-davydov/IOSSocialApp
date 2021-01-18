//
//  Groups.swift
//  SocialApp
//
//  Created by Дима Давыдов on 22.11.2020.
//

import Foundation
import Alamofire
import PromiseKit

enum GroupType: String {
    case group, page, event
}



class GroupsApiEndpoint: VKClient {
    
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
    
    func get(request parameters: GroupsGetRequest) -> Promise<GroupsGetResponse> {
        return promise(request: parameters, decode: GroupsGetResponse.self)
    }
}

