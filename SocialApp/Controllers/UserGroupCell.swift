//
//  GlobalGroupsTableViewCell.swift
//  SocialApp
//
//  Created by Дима Давыдов on 02.10.2020.
//

import UIKit

class UserGroupCell: UITableViewCell {
    func animationView() -> UIView? {
        return avatar
    }
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    var cellAnimation = ScaleViewCellAnimation()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellAnimation.animationView = avatar
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            cellAnimation.startOutAnimation(complete: {super.setSelected(selected, animated: animated)})
            
            return
        }
        
        super.setSelected(selected, animated: animated)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if !highlighted { return }
        cellAnimation.startInAnimation(complete: {})
    }
}
