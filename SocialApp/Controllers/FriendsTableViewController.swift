//
//  PersonalGroupsTableViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 02.10.2020.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    var clickedUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FriendsDataProvider.instance.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserTableCell else {
            fatalError("The dequeued cell is not an instance of UserTableCell.")
        }

        let user = FriendsDataProvider.instance[indexPath.row]!
        cell.user = user
        cell.name.text = user.name
        cell.avatarView.loadFrom(url: user.getImageURL())
    
        return cell
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UserTableCell

        let destintaion = segue.destination as! UserCollectionViewController
        destintaion.userImage = cell.avatarView.image
        destintaion.title = cell.user!.name
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("end display row: \(indexPath.row)")
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserTableCell else {
            fatalError("The dequeued cell is not an instance of UserTableCell.")
        }
        
        cell.avatarView.clearSubviews()
        cell.avatarView = nil
        print("got cell")
    }
}
