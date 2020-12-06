//
//  NewsItemPhoto.swift
//  SocialApp
//
//  Created by Дима Давыдов on 29.11.2020.
//

import Foundation
import UIKit

protocol AttachmentViewDelegate: class {
    func render()
    func clear()
}

class NewsItemAttachmentPhotos: AttachmentViewDelegate {
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
            
            subview?.frame = CGRect(x: 0, y: 0, width: attachment.sizes[0].width, height: attachment.sizes[0].height)
            
            
            view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width, height: CGFloat(attachment.sizes[0].height))
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: CGFloat(attachment.sizes[0].height)).isActive = true
            
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
