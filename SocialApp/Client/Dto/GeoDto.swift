//
//  GeoDto.swift
//  SocialApp
//
//  Created by Дима Давыдов on 24.11.2020.
//

import Foundation

struct GeoPlace: Codable {
    // идентификатор места.
    var id: Int
    
    // название места.
    var title: String
    
    // географическая широта, заданная в градусах (от -90 до 90).
    var latitude: Int
    
    // географическая широта, заданная в градусах (от -90 до 90).
    var longitude: Int
    
    // дата создания места в Unixtime.
    var created: Int
    
    // иконка места, URL изображения.
    var icon: String
    
    // число отметок в этом месте.
    var checkins: Int
    
    // дата обновления места в Unixtime.
    var updated: Int
    
    // тип места.
    var type: Int
    
    // идентификатор страны.
    var country: Int
    
    // идентификатор города.
    var city: Int
    
    // адрес места.
    var address: String
}

struct Geo: Codable {
    // тип места;
    var type: String
    // координаты места;
    var coordinates: String
    // описание места (если оно добавлено). Объект места.
    var place: GeoPlace
}
