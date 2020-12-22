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
        
        guard let thumb = attachment.sizes.find(by: .x) else { return }
        
        if let url = URL(string: thumb.url),
           let data = try? Data(contentsOf: url),
           let img = UIImage(data: data) {
            
            subview = UIImageView(image: img)

            subview?.translatesAutoresizingMaskIntoConstraints = false
                        
            let aspectRatio = CGFloat(thumb.height) / CGFloat(thumb.width)
            let newHeight = aspectRatio * view.frame.width

            subview?.contentMode = .scaleAspectFill
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: CGFloat(newHeight)).isActive = true
            
            view.addSubview(subview!)
            subview?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            subview?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            subview?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            subview?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
