//
//  NewsItemPhoto.swift
//  SocialApp
//
//  Created by Дима Давыдов on 29.11.2020.
//

import Foundation
import UIKit

class NewsItemAttachmentPhoto: AttachmentViewDelegate {
    weak var view: UIView!
    var attachment: AttachmentPhoto
    var subview: UIView?
    
    
    internal init(view: UIView, attachment: AttachmentPhoto) {
        self.view = view
        self.attachment = attachment
    }
    
    
    func render(){
        if let url = URL(string: attachment.sizes[0].url),
           let data = try? Data(contentsOf: url),
           let img = UIImage(data: data) {
            
            subview = UIImageView(image: img)
            
            let aspectRatio = CGFloat(attachment.sizes[0].height) / CGFloat(attachment.sizes[0].width)
            let newHeight = aspectRatio * view.frame.width - 15
            
            subview?.frame = CGRect(x: 0, y: 0, width: view.frame.width - 15, height: newHeight)
            subview?.contentMode = .scaleToFill
            
            view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width - 15, height: newHeight)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: CGFloat(newHeight)).isActive = true
            
            view.addSubview(subview!)
        }
    }
    
    func clear() {
        subview?.removeFromSuperview()
        subview = nil
    }
    
    deinit {
        print("deinit")
    }
}
