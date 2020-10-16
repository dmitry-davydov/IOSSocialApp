//
//  PersonalGroupsTableViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 02.10.2020.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var indexedUsers = [[User]]()
    var sections = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        indexUsers(nil)
    }

    private func indexUsers(_ st: String?) {
        
        var searchText = st
        
        if searchText != nil && searchText?.count == 0 {
            searchText = nil
        }
        
        let data = FriendsDataProvider.instance.getData()
        
        for user in data {
            
            if let st = searchText {
                if !user.name.contains(st) { continue }
            }
            
            let firstLetter = String(user.name.first!)
    
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
        cell.name.text = user.name
        
        if let img = user.imageInstance {
            cell.avatarView.setImage(img)
        } else {
            cell.avatarView.loadFrom(url: user.getImageURL())
        }
        
        return cell
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UserTableCell
        let destintaion = segue.destination as! UserCollectionViewController
        
        let selectedIndexPath = self.tableView.indexPathForSelectedRow!
        
        let selectedUser = indexedUsers[selectedIndexPath.section][selectedIndexPath.row]
        
        destintaion.userImage = selectedUser.imageInstance
        destintaion.title = cell.user!.name
    }

}

extension FriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sections = [String]()
        indexedUsers = [[User]]()
        indexUsers(searchText)
        self.tableView.reloadData()
        
    }
}
