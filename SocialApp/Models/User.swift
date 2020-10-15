//
//  User.swift
//  SocialApp
//
//  Created by Дима Давыдов on 04.10.2020.
//

import Foundation
import UIKit

class User: IDProtocol {
    var uid: String
    var name: String
    var image: String
    
    init(uid: String, name: String, image: String) {
        self.uid = uid
        self.name = name
        self.image = image
        
        loadImage()
    }
    
    private func loadImage() {
        DispatchQueue.global(qos: .userInteractive).async {
            guard let imageUrl = URL(string: self.image) else {
                fatalError("Cannot parse \(self.image) as URL object")
            }
            
            let imageData = try? Data(contentsOf: imageUrl)
            
            self.imageInstance = UIImage(data: imageData!)
        }
    }
    
    var imageInstance: UIImage?
    
    func getImageURL() -> URL {
        return URL.init(string: self.image)!
    }
    
    func getID() -> String {
        return uid
    }
}
