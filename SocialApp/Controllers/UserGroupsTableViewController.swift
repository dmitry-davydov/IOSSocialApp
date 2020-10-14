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
        return UserGroupsDataProvider.instance.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = UserGroupsDataProvider.instance[indexPath.row] else {
            fatalError("Out of user groups")
        }
        
        var cell: UserGroupCell
        
        cell = (tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? UserGroupCell)!
        
        cell.name.text = item.name
        cell.avatar.loadFrom(url: item.getImageURL())

        return cell
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "AddGroupSegue" {
            self.tableView.reloadData()
        }
    }
}
