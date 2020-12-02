//
//  NewsItemTableViewCell.swift
//  SocialApp
//
//  Created by Дима Давыдов on 16.10.2020.
//

import UIKit

class NewsItemTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var newsItemImage: UIImageView!
    @IBOutlet weak var viewedCount: UILabel!
    @IBOutlet weak var likeUiButton: LikeUIButton!
    
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
        
        if let attachments = newsItem.attachments, attachments.count > 0 {
            for attachment in attachments {
                var t = 1
            }
        }
        
        viewedCount.text = String(newsItem.views.count)
        likeUiButton.counterValue = newsItem.likes.count
        if let isUserLiked = newsItem.likes.userLikes {
            likeUiButton.isLiked = isUserLiked == 1 ? true : false
        }
    }
}

extension NewsItemTableViewCell: LikeUIButtonDelegate {
    func willUpdateLikeCounter(isLiked: Bool, currentCounterValue: Int) -> Int {
        return isLiked
            ? currentCounterValue + Int.random(in: 2...5)
            : currentCounterValue - 1
    }
}
