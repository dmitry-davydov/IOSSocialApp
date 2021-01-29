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
    
    static let shared: ImageCacheService = ImageCacheService()
    
    private init(){}
    
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
            
            print("[ImageCacheService] \(url.relativePath) was loaded from cache")
            // получить картинку из кеша
            return Promise.value(UIImage(data: cache.readCachedFile(from: url)!)!)
        }
        
        print("[ImageCacheService] \(url.relativePath) was loaded from server")
        
        // скачать картинку
        return Promise { [weak self] promise in
            DispatchQueue.global(qos: .userInteractive).async {
                AF.request(url).responseData(completionHandler: { (response) in
                    
                    guard let data = response.data else {
                        promise.reject(Errors.fileCanNotBeDownloaded)
                        return
                    }
                     
                    self?.cache.saveCachedFile(by: url, data: data)
                    promise.resolve(UIImage(data: data), nil)
                })
            }
            
        }
    }
}
