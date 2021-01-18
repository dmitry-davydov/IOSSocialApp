//
//  ImageCacheService.swift
//  SocialApp
//
//  Created by Дима Давыдов on 18.01.2021.
//

import Foundation
import UIKit
import PromiseKit
import Alamofire

class ImageCacheService {
    let cache: CacheService = CacheService(category: "image")
    let cacheLifetime: Int = 86400 * 30 // 30 дней
    
    enum Errors: Error {
        case fileCanNotBeDownloaded
    }
    
    func getImage(by url: URL) -> Promise<UIImage> {
        
        if cache.isFileExists(url: url) {
            
            if Int(Date.init().timeIntervalSince1970) - cache.getFileCreated(for: url) > cacheLifetime {
                // файл в кеше невалиден
                // удалить его
                cache.deleteFile(url: url)
                
                return getImage(by: url)
            }
            
            // получить картинку из кеша
            return Promise.value(UIImage(data: cache.readCachedFile(from: url)!)!)
        }
        
        // скачать картинку
        return Promise { [weak self] promise in
            AF.request(url).responseData(completionHandler: { [weak self] (response) in
                
                guard let data = response.data,
                      !(self?.cache.saveCachedFile(by: url, data: data) ?? false) else {
                    promise.reject(Errors.fileCanNotBeDownloaded)
                    return 
                }
                    
                promise.resolve(UIImage(data: data), nil)
            })
        }
    }
}
