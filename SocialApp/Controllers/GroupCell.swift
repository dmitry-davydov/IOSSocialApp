//
//  GroupCell.swift
//  SocialApp
//
//  Created by Дима Давыдов on 15.10.2020.
//

import Foundation
import UIKit

class GroupCell: UITableViewCell {
    
    var gid: String!
    
    @IBOutlet weak var label: UILabel!
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
