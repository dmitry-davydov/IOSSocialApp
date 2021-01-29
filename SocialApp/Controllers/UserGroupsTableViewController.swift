//
//  GlobalGroupsTableViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 02.10.2020.
//

import UIKit
import RealmSwift
import os.log

class UserGroupsTableViewController: UITableViewController {
    
    var userGroups: Results<GroupsRealmModel>?
    var realmNotificationToken: NotificationToken?
    
    var userGroupsCount: Int {
        return userGroups?.count ?? 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delaysContentTouches = false
        
        GroupsDataProvider.shared
            .getData()
            .done(on: .main) { [weak self] (result) in
                self?.userGroups = result
                self?.tableView.reloadData()
                print("done with groups promise")
            }
            .catch { (err) in
                debugPrint(err.localizedDescription)
            }
        
        realmNotificationToken = userGroups?._observe(.main, { [weak self] realmCollectionChange in
            switch realmCollectionChange {
            case .error(let err):
                os_log(.error, "Realm notification err: \(err.localizedDescription)")
            
            case let .update(_, deletions, insertions, modifications):
                os_log(.info, "Realm notification update: insertions: \(insertions) modifications: \(modifications) deletions: \(deletions)")
                
                self?.tableView.beginUpdates()
                self?.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                self?.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                self?.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                self?.tableView.endUpdates()
                
            case .initial(_):
                os_log(.error, "Realm notification initial")
            }
        })
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userGroupsCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = userGroups?[indexPath.row] else {
            fatalError("Out of user groups")
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserGroupCell", for: indexPath) as? UserGroupCell else {
            fatalError("Can not convert Cell to UserGroupCell")
        }
        
        cell.name.text = item.name
        cell.avatar.loadFrom(url: URL(string: item.avatar)!)
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GroupSegue" {
            guard let vc = segue.destination as? NewsItemTableViewController else { return }

            guard let userGroup = self.userGroups?[self.tableView.indexPathForSelectedRow!.row] else {
                fatalError("Could not find user group")
            }

            vc.ownerId = userGroup.groupId
            vc.title = userGroup.name
        }
    }
}
