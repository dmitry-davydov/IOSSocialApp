//
//  AlbumASCell.swift
//  SocialApp
//
//  Created by Дима Давыдов on 31.01.2021.
//

import Foundation
import AsyncDisplayKit

//class AlbumASCell: ASCellNode {
//
//    private let photo: PhotoSize
//    private var image: ASNetworkImageNode = ASNetworkImageNode()
//
//    
//    init(photo size: PhotoSize) {
////        self.photo = size
//        
////        super.init()
//    }
//    
//    
//    private func setupSubnodes() {
//        guard let url = URL(string: photo.url) else { return }
//        image.url = url
//        image.contentMode = .scaleAspectFit
//        image.shouldRenderProgressImages = true
//        
//        addSubnode(image)
//    }
//
//    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
//        let width = constrainedSize.max.width
//        image.style.preferredSize = CGSize(width: width, height: width * photo.aspectRatio())
//        
//        return ASWrapperLayoutSpec(layoutElement: image)
//    }
//    
//}
