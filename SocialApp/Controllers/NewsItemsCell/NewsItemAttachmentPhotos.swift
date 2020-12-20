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
    var attachment: [AttachmentPhoto]
    var subview: UIView?
    
    
    internal init(view: UIView, attachment: [AttachmentPhoto]) {
        self.view = view
        self.attachment = attachment
    }
    
    
    func render(){
        
        if attachment.count == 1 {
            NewsItemAttachmentPhoto(view: view, attachment: attachment.first!).render()
            return
        }
        
        // 2
        // 3
        // 2
        
        var attachmentsPhoto = attachment
        
        
        let rowsCount: Int = Int(ceil(Double(attachment.count) / Double(3)))
        
        let mainStack = UIStackView()
        mainStack.alignment = .fill
        mainStack.distribution = .fillProportionally
        mainStack.axis = .vertical
        mainStack.spacing = 5
        
        for _ in 0..<rowsCount {
            let st = UIStackView()
            st.alignment = .fill
            st.distribution = .fillProportionally
            st.axis = .horizontal
            st.spacing = 5
            
            for _ in 0..<3 {
                if attachmentsPhoto.count == 0 { break }
                let photo = attachmentsPhoto.removeFirst()
                 
                guard let thumb = photo.sizes.find(by: .o),
                      let url = URL(string: thumb.url),
                      let data = try? Data(contentsOf: url),
                      let img = UIImage(data: data) else { continue }
                
                let imgView = UIImageView(image: img)
                imgView.clipsToBounds = true
                imgView.contentMode = .scaleAspectFill
                
                st.addArrangedSubview(imgView)
            }
            
            mainStack.addArrangedSubview(st)
        }
        
        subview = mainStack
        
        subview?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStack)
        
        subview?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        subview?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        subview?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        subview?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func clear() {
        subview?.removeFromSuperview()
        subview = nil
    }
    
    deinit {
        print("deinit")
    }
}
