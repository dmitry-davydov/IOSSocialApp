//
//  PersonalGroupsTableViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 02.10.2020.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    var dataProvider: MemoryDataProvider<User> = MemoryDataProvider<User>()
    var clickedUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    private func loadData() {
        _ = dataProvider
            .addDataItem(item: User(uid: UUID.init().uuidString, name: "User1", image: "https://picsum.photos/200"))
            .addDataItem(item: User(uid: UUID.init().uuidString, name: "User2", image: "https://picsum.photos/200"))
            .addDataItem(item: User(uid: UUID.init().uuidString, name: "User3", image: "https://picsum.photos/200"))
            .addDataItem(item: User(uid: UUID.init().uuidString, name: "User4", image: "https://picsum.photos/200"))
            .addDataItem(item: User(uid: UUID.init().uuidString, name: "User5", image: "https://picsum.photos/200"))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataProvider.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserTableCell else {
            fatalError("The dequeued cell is not an instance of UserTableCell.")
        }

        let user = dataProvider[indexPath.row]!
        cell.user = user
        cell.name.text = user.name
        cell.avatar.loadFrom(url: user.getImageURL())
    
        return cell
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UserTableCell

        let destintaion = segue.destination as! UserCollectionViewController
        destintaion.userImage = cell.avatar.image
        destintaion.title = cell.user!.name
    }
}
