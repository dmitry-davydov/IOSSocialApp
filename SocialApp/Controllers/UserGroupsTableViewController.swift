//
//  GlobalGroupsTableViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 02.10.2020.
//

import UIKit

class UserGroupsTableViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupsDataProvider.instance.userGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = GroupsDataProvider.instance.userGroups[indexPath.row] else {
            fatalError("Out of user groups")
        }
        
        var cell: UserGroupCell
        
        cell = (tableView.dequeueReusableCell(withIdentifier: "UserGroupCell", for: indexPath) as? UserGroupCell)!
        
        cell.name.text = item.name
        
        if let imgInstance = item.imageInstance {
            cell.avatar.image = imgInstance
        } else {
            cell.avatar.loadFrom(url: item.getImageURL())
        }
        
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let item = GroupsDataProvider.instance.userGroups[indexPath.row] else {
                fatalError("Out of user groups")
            }
            
            GroupsDataProvider.instance.deleteUserGroup(item)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "AddGroupSegue" {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GroupSegue" {
            guard let vc = segue.destination as? NewsItemTableViewController else { return }
            
            guard let userGroup = GroupsDataProvider.instance.userGroups[self.tableView.indexPathForSelectedRow!.row] else {
                fatalError("Could not find user group")
            }
            
            vc.title = userGroup.name
            
        }
    }
}
