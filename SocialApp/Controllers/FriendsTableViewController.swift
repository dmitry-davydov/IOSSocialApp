//
//  PersonalGroupsTableViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 02.10.2020.
//

import UIKit
import RealmSwift
import os.log

class FriendsTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var userFriends: Results<FriendsRealmModel>?
    var indexedUsers = [[FriendsRealmModel]]()
    var sections = [String]()
    private var notificationToken: NotificationToken?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delaysContentTouches = false
        searchBar.delegate = self
        fetchUserFollowers()
    }
    
    private func fetchUserFollowers() {
        userFriends = FriendsDataProvider.shared.getData()
        
        notificationToken = userFriends?.observe(on: .main, { [weak self] (collectionChange) in
            switch collectionChange {
            case .initial(let results):
                self?.indexUsers(results, searchString: nil)
                self?.tableView.reloadData()
                os_log(.info, "Realm - Initial notification")
            case .error(let error):
                os_log(.info, "Realm - error notification: \(error.localizedDescription)")
            case let .update(results, _, _, _):
                os_log(.info, "Realm - Updated notification")
                self?.indexUsers(results, searchString: nil)
                self?.tableView.reloadData()
            }
        })
    }

    private func indexUsers(_ results: Results<FriendsRealmModel>?, searchString: String?) {
        
        let userFriendsResults = results != nil ? results : userFriends
        
        guard let results = userFriendsResults else {
            return
        }
        
        indexedUsers = [[FriendsRealmModel]]()
        
        var searchText: String?
        if let searchString = searchString, searchString.count > 0 {
            searchText = searchString
        }
        
        for user in results {
            
            if let st = searchText {
                if !user.fullName.contains(st) { continue }
            }
            
            let firstLetter = String(user.fullName.first!)

            let indexOfLetter = sections.firstIndex(of: firstLetter)

            if indexOfLetter == nil {
                sections.append(firstLetter)
                indexedUsers.append([user])
                continue
            }

            indexedUsers[indexOfLetter!].append(user)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return indexedUsers.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return indexedUsers[section].count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = indexedUsers[indexPath.section][indexPath.row]
        let vc = UserCollectionViewController(userModel: selectedUser)
        
        show(vc, sender: self)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserTableCell else {
            fatalError("The dequeued cell is not an instance of UserTableCell.")
        }

        let user = indexedUsers[indexPath.section][indexPath.row]
        cell.user = user
        cell.name.text = user.fullName
        
        cell.avatarView.loadFrom(url: URL(string: user.avatar)!)
        
        
        return cell
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        let destintaion = segue.destination as! UserCollectionViewController
//
//        let selectedIndexPath = self.tableView.indexPathForSelectedRow!
//        let selectedUser = indexedUsers[selectedIndexPath.section][selectedIndexPath.row]
//        destintaion.user = selectedUser
//    }

}

extension FriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sections = [String]()
        indexedUsers = [[FriendsRealmModel]]()
        indexUsers(nil, searchString: searchText)
        self.tableView.reloadData()
    }
}
