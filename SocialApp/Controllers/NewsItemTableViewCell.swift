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
    
    func prepareCell(_ newsItem: NewsItem) {
        title.text = newsItem.title
        
        if let url = URL(string: newsItem.imageUrl) {
            newsItemImage.loadFrom(url: url)
        }
        
        viewedCount.text = String(newsItem.viewedCount)
        likeUiButton.counterValue = newsItem.likesCount
        likeUiButton.isLiked = newsItem.isLiked
    }
}

extension NewsItemTableViewCell: LikeUIButtonDelegate {
    func willUpdateLikeCounter(isLiked: Bool, currentCounterValue: Int) -> Int {
        return isLiked
            ? currentCounterValue + Int.random(in: 2...5)
            : currentCounterValue - 1
    }
}
