//
//  NewsItemTableViewCell.swift
//  SocialApp
//
//  Created by Дима Давыдов on 16.10.2020.
//

import UIKit

class NewsItemTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var viewedCount: UILabel!
    @IBOutlet weak var likeUiButton: LikeUIButton!
    @IBOutlet weak var middleView: UIView!
    
    var attachmentRendererDelegate: AttachmentViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        likeUiButton.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareCell(_ newsItem: GroupItemDto) {
        title.text = newsItem.text
        viewedCount.text = String(newsItem.views.count)
        likeUiButton.counterValue = newsItem.likes.count
        if let isUserLiked = newsItem.likes.userLikes {
            likeUiButton.isLiked = isUserLiked == 1 ? true : false
        }
        
        
        if let attachments = newsItem.attachments {
            
            
            
            
            for attachment in attachments {
                switch attachment {
                case .photo(let attachmentPhoto):
                    
                    if attachments.count == 1 {
                        attachmentRendererDelegate = NewsItemAttachmentPhoto(view: self.middleView, attachment: attachmentPhoto)
                    } else {
                        attachmentRendererDelegate = NewsItemAttachmentPhotos(view: self.middleView, attachment: attachmentPhoto)
                    }
                    
                    
                    attachmentRendererDelegate?.render()
                    
                    debugPrint(attachmentPhoto)
                default:
                    print("Not impltemented \(attachment)")
                }
            }
        }
    }
    
    func clear() {
        attachmentRendererDelegate?.clear()
        attachmentRendererDelegate = nil
    }
}

extension NewsItemTableViewCell: LikeUIButtonDelegate {
    func willUpdateLikeCounter(isLiked: Bool, currentCounterValue: Int) -> Int {
        return isLiked
            ? currentCounterValue + Int.random(in: 2...5)
            : currentCounterValue - 1
    }
}
