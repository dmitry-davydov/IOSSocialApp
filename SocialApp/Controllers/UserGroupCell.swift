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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        if selected {
            UIView.animate(withDuration: 0.1, delay: 0, options: [.beginFromCurrentState], animations: {
                self.avatar.transform = .identity
            }, completion: {(_) in
                super.setSelected(selected, animated: animated)
            })
            
            return
        }
        
        super.setSelected(selected, animated: animated)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
        super.setHighlighted(highlighted, animated: animated)
        
        if !highlighted { return }
        UIView.animate(withDuration: 0.1, delay: 0, options: [.beginFromCurrentState], animations: {
            self.avatar.transform = self.avatar.transform.scaledBy(x: 0.9, y: 0.9)
        }, completion: {(_) in
            
        })
    }
}
