//
//  GlobalGroupsTableViewCell.swift
//  SocialApp
//
//  Created by Дима Давыдов on 02.10.2020.
//

import UIKit

class UserGroupCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
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
