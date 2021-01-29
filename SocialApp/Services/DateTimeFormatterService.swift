//
//  DateTimeFormatterService.swift
//  SocialApp
//
//  Created by Дима Давыдов on 23.01.2021.
//

import Foundation
import PromiseKit

final class DateTimeFormatterService {
    
    private static var instances: [String: DateTimeFormatterService] = [:]
    
    let formatter = DateFormatter()
    
    init(format: String = "dd.MM.yyyy HH.mm") {
        formatter.dateFormat = format
    }
    
    class func getInstance(format: String) -> DateTimeFormatterService {
        if let instance = instances[format] {
            return instance
        }
        
        let instance = Self(format: format)
        instances[format] = instance
        
        return instance
    }
    
    func format(from timeInterval: TimeInterval) -> Promise<String> {
        return Promise() { [weak self] promise in
            DispatchQueue.global(qos: .userInteractive).async {
                
                guard let self = self else {
                    promise.resolve("DateTimeFormatterService", nil)
                    debugPrint("Obj deinited")
                    return
                }
                
                let date = Date(timeIntervalSince1970: timeInterval)
                promise.resolve(self.formatter.string(from: date), nil)
            }
        }
    }
}


