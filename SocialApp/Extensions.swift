//
//  Extensions.swift
//  SocialApp
//
//  Created by Дима Давыдов on 05.10.2020.
//

import Foundation
import UIKit

protocol ImageUrlLoadble {
    func imageLoaded()
}

extension ImageUrlLoadble {
    func imageLoaded() {}
}

extension UIImageView: ImageUrlLoadble {
    
    
    func loadFrom(url: URL) {
        DispatchQueue.global(qos: .userInteractive).async {
            
            let imageData = try? Data(contentsOf: url)
            
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData!)
                self.imageLoaded()
            }
        }
    }
}

