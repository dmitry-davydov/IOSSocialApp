//
//  Group.swift
//  SocialApp
//
//  Created by Дима Давыдов on 04.10.2020.
//

import Foundation
import UIKit

class Group: IDProtocol {
    var gid: String
    var name: String
    var image: String
    
    var imageInstance: UIImage?
    
    func getImageURL() -> URL {
        return URL.init(string: self.image)!
    }
    
    func getID() -> String {
        return gid
    }
    
    init(gid: String, name: String, image: String) {
        self.gid = gid
        self.name = name
        self.image = image
        
        guard let url = URL(string: image) else { return }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let imageData = try? Data(contentsOf: url)
            self?.imageInstance = UIImage(data: imageData!)
        }
    }
}
