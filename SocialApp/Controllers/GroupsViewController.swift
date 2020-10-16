//
//  GroupsViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 15.10.2020.
//

import UIKit

class GroupsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupsDataProvider.instance.getDataCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = GroupsDataProvider.instance[indexPath.row] else {
            fatalError("Out of user groups")
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell else {
            fatalError("Can not cast cell as GroupCell")
        }
        
        cell.label.text = item.name
        
        if let imgInstance = item.imageInstance {
            cell.avatar.image = imgInstance
        } else {
            cell.avatar.loadFrom(url: item.getImageURL())
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell else {
            fatalError("Can not cast cell as GroupCell")
        }
        
        guard let group = GroupsDataProvider.instance[indexPath.row] else {
            fatalError("Can not find group with \(cell.gid ?? "unknown") gid")
        }
            
        GroupsDataProvider.instance.addUserGroup(group)
        
        
        self.performSegue(withIdentifier: "AddGroupSegue", sender: nil)
    }
    
}
