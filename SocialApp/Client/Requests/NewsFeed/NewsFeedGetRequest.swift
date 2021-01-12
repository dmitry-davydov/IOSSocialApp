//
//  NewsFeedGetRequest.swift
//  SocialApp
//
//  Created by Дима Давыдов on 30.12.2020.
//

import Foundation
import Alamofire

struct NewsFeedGetRequest: RequestProtocol {
    
    private let maxCountNumber = 100
    private let maxPhotosCount = 100
    
    enum Filters: String {
        // новые записи со стен
        case post
        
        // новые фотографии
        case photo
        
        // новые отметки на фотографиях
        case photoTag = "photo_tag"
        
        // новые фотографии на стенах
        case wallPhoto = "wall_photo"
        
        // новые друзья
        case friend
        
        // новые заметки
        case note
        
        // записи сообществ и друзей, содержащие аудиозаписи, а также новые аудиозаписи, добавленные ими
        case audio
        
        // новые видеозаписи
        case video
    }
    
    // Если параметр не задан, то будут получены все возможные списки новостей
    var filters: [Filters]?
    
    // true - включить в выдачу также скрытых из новостей пользователей.
    // false - не возвращать скрытых пользователей
    var returnBanned: Bool = false
    
    // время в формате unixtime, начиная с которого следует получить новости для текущего пользователя
    var startTime: Int?
    
    // время в формате unixtime, до которого следует получить новости для текущего пользователя.
    // Если параметр не задан, то он считается равным текущему времени
    var endTime: Int?
    
    // Максимальное количество фотографий, информацию о которых необходимо вернуть.
    // По умолчанию: 5, максимальное значение: 100
    var maxPhotos: Int = 5
    
    // Идентификатор, необходимый для получения следующей страницы результатов.
    // Значение, необходимое для передачи в этом параметре, возвращается в поле ответа next_from
    var startFrom: Int?
    
    // указывает, какое максимальное число новостей следует возвращать, но не более 100.
    // По умолчанию 50
    var count: Int = 50
    
    // список дополнительных полей для профилей, которые необходимо вернуть.
    var userFields: [UsersFollowersRequestFields]?
    
    // список дополнительных полей для групп, которые необходимо вернуть.
    var groupFields: [GroupsGetRequestFields]?
    
    var section: String?
    
    func asParameters() -> Parameters {
        
        var params: Parameters = [
            "return_banned": (returnBanned ? 1 : 0).asString(),
            "max_photos": (maxPhotos > maxPhotosCount ? maxPhotosCount : maxPhotos).asString(),
            "count": (count > maxCountNumber ? maxCountNumber : count).asString()
        ]
        
        if let startTime = startTime {
            params["start_time"] = startTime.asString()
        }
        
        var fields: [String] = []
        
        if let endTime = endTime {
            params["end_time"] = endTime.asString()
        }
        
        //startFrom
        if let startFrom = startFrom {
            params["start_from"] = startFrom.asString()
        }

        //userFields
        if let userFields = userFields {
            fields += userFields.map{$0.rawValue}
        }
        
        //groupFields
        if let groupFields = groupFields {
            fields += groupFields.map{$0.rawValue}
        }
        
        //section
        if let section = section {
            params["section"] = section
        }
        
        if fields.count > 0 {
            params["fields"] = fields.joined(separator: ",")
        }
        
        if let filters = filters {
            params["filters"] = filters.map({$0.rawValue}).joined(separator: ",")
        }
        
        return params
    }
    
    func getMethod() -> VKMethod {
        return VKMethod("newsfeed.get")
    }
}
