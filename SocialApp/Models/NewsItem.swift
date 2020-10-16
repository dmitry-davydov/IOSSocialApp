//
//  NewsItem.swift
//  SocialApp
//
//  Created by Дима Давыдов on 16.10.2020.
//

import Foundation
import UIKit

class NewsItem:IDProtocol {
    
    var id: String
    var title: String
    var imageUrl: String
        
    var likesCount: Int = 0
    var isLiked: Bool = false
    var viewedCount: Int = 0
    
    
    init(id: String, title: String, imageUrl: String, likesCount: Int, isLiked: Bool, viewedCount: Int) {
        self.id = id
        self.title = title
        self.likesCount = likesCount
        self.isLiked = isLiked
        self.viewedCount = viewedCount
        self.imageUrl = imageUrl
    }
    
    func getID() -> String {
        return id
    }
}
