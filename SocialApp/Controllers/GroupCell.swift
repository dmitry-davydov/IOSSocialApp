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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
