//
//  PersonalGroupsTableViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 02.10.2020.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var indexedUsers = [[UserDto]]()
    var sections = [String]()
    
    var userFollowers: UsersFollowersResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delaysContentTouches = false
        searchBar.delegate = self
        fetchUserFollowers()
        
    }
    
    private func fetchUserFollowers() {
        let userEndpoint = Users()
        let requestObject = UsersFollowersRequest(userId: nil, offset: 0, count: nil, fields: [.nickname, .photo100], nameCase: .nom)
        
        userEndpoint.getFollowers(request: requestObject) { response in
            if let err = response.error {
                debugPrint(err)
                return
            }
            
            guard let userResponse = response.response else { return }
            
            self.userFollowers = userResponse
            self.indexUsers(nil)
            self.tableView.reloadData()
        }
    }

    private func indexUsers(_ st: String?) {

        var searchText = st

        if searchText != nil && searchText?.count == 0 {
            searchText = nil
        }

        guard let users = userFollowers?.items else { return }
        

        for user in users {
            
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
        
        cell.avatarView.loadFrom(url: URL(string: user.photo100!)!)
        
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UserTableCell
        let destintaion = segue.destination as! UserCollectionViewController
        
        let selectedIndexPath = self.tableView.indexPathForSelectedRow!
        let selectedUser = indexedUsers[selectedIndexPath.section][selectedIndexPath.row]
        destintaion.user = selectedUser
    }

}

extension FriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sections = [String]()
        indexedUsers = [[UserDto]]()
        indexUsers(searchText)
        self.tableView.reloadData()
        
    }
}
