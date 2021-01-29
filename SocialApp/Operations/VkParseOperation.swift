//
//  VkParseOperation.swift
//  SocialApp
//
//  Created by Дима Давыдов on 13.01.2021.
//

import Foundation

class VkParseOperation<T>: AsyncOperation where T: Decodable {
    var response: VKResponse<T?, Error?>?
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override func main() {
        guard let vkRequestOperation = self.dependencies.first as? VkRequestOperation,
              let response = vkRequestOperation.result else {
            self.state = .finished
            return
        }
        
        switch response.result {
        case .success(_):
            do {
                guard let data = response.data else { return }
                let groupsGetResponse = try JSONDecoder().decode(T.self, from: data)
                self.response = VKResponse(response: groupsGetResponse, error: nil)
            } catch let DecodingError.keyNotFound(key, context) {
                self.response = VKResponse(response: nil, error: DecodingError.keyNotFound(key, context))
            } catch let err as NSError {
                self.response = VKResponse(response: nil, error: err)
            }
            
        case .failure(let err):
            self.response = VKResponse(response: nil, error: err)
        }
        
        self.state = .finished
    }
}
