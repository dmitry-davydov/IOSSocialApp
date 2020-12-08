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
        let friends = FriendsDataProvider.shared.getData()
        
        notificationToken = friends.observe(on: .main, { [weak self] (collectionChange) in
            switch collectionChange {
            case .initial(let results):
                self?.doIndex(results)
                self?.tableView.reloadData()
                os_log(.info, "Realm - Initial notification")
            case .error(let error):
                os_log(.info, "Realm - error notification: \(error.localizedDescription)")
            case let .update(results, _, _, _):
                os_log(.info, "Realm - Updated notification")
                self?.doIndex(results)
                self?.tableView.reloadData()
                
//                self?.tableView.beginUpdates()
//
//                self?.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
//                self?.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
//                self?.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
//
//                self?.tableView.endUpdates()
            }
        })
    }

    private func doIndex(_ results: Results<FriendsRealmModel>) {
        
        indexedUsers = [[FriendsRealmModel]]()
        
        for user in results {
            
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
    
    private func indexUsers(_ st: String?) {

        var searchText = st

        if searchText != nil && searchText?.count == 0 {
            searchText = nil
        }

        guard let userFriends = userFriends else { return }
        
        for user in userFriends {
            
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destintaion = segue.destination as! UserCollectionViewController
        
        let selectedIndexPath = self.tableView.indexPathForSelectedRow!
        let selectedUser = indexedUsers[selectedIndexPath.section][selectedIndexPath.row]
        destintaion.user = selectedUser
    }

}

extension FriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sections = [String]()
        indexedUsers = [[FriendsRealmModel]]()
        indexUsers(searchText)
        self.tableView.reloadData()
    }
}
