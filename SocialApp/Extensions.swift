//
//  Extensions.swift
//  SocialApp
//
//  Created by Дима Давыдов on 05.10.2020.
//

import Foundation
import UIKit

extension UIImageView {
    func loadFrom(url: URL) {
        
        let _ = ImageCacheService.shared
            .getImage(by: url)
            .done(on: .main) { [weak self] (img) in
                self?.image = img
                self?.clipsToBounds = true
            }
    }
}

extension UIView{
    func setAnchorPoint(anchorPoint: CGPoint) {

        var newPoint = CGPoint(x: self.bounds.size.width * anchorPoint.x, y: self.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPoint(x: self.bounds.size.width * self.layer.anchorPoint.x, y: self.bounds.size.height * self.layer.anchorPoint.y)

        newPoint = newPoint.applying(self.transform)
        oldPoint = oldPoint.applying(self.transform)

        var position : CGPoint = self.layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x;

        position.y -= oldPoint.y;
        position.y += newPoint.y;

        self.layer.position = position;
        self.layer.anchorPoint = anchorPoint;
    }
}

extension Int {
    func asString() -> String {
        return "\(self)"
    }
}


