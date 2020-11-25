//
//  GlobalGroupsTableViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 02.10.2020.
//

import UIKit

class UserGroupsTableViewController: UITableViewController {
    
    var userGroupsResponse: GroupsGetResponse?
    
    var userGroupsCount: Int {
        return userGroupsResponse?.count ?? 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delaysContentTouches = false
        
        let groupsEndpoint = Groups()
        
        groupsEndpoint.get(request: GroupsGetRequest()) { (response) in
            
            if let error = response.error {
                print(error)
                return
            }
            
            if let groupsResponse = response.response {
                self.userGroupsResponse = groupsResponse
                self.tableView.reloadData()
            }
            
        }
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userGroupsCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = userGroupsResponse?.items[indexPath.row] else {
            fatalError("Out of user groups")
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserGroupCell", for: indexPath) as? UserGroupCell else {
            fatalError("Can not convert Cell to UserGroupCell")
        }
        
        cell.name.text = item.name
        cell.avatar.loadFrom(url: URL(string: item.photo100)!)
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            guard let item = GroupsDataProvider.instance.userGroups[indexPath.row] else {
//                fatalError("Out of user groups")
//            }
//
//            GroupsDataProvider.instance.deleteUserGroup(item)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "AddGroupSegue" {
            self.tableView.reloadData()
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "GroupSegue" {
//            guard let vc = segue.destination as? NewsItemTableViewController else { return }
//
//            guard let userGroup = GroupsDataProvider.instance.userGroups[self.tableView.indexPathForSelectedRow!.row] else {
//                fatalError("Could not find user group")
//            }
//
//            vc.title = userGroup.name
//
//        }
//    }
}
