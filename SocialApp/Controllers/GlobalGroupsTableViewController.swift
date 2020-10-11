//
//  GlobalGroupsTableViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 02.10.2020.
//

import UIKit

class GlobalGroupsTableViewController: UITableViewController {

    var data: [String] = [
        "Global Group 1",
        "Global Group 2",
        "Global Group 3",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GlobalGroupsViewCell", for: indexPath) as? GlobalGroupsTableViewCell else {
            fatalError("The dequeued cell is not an instance of GlobalGroupsTableViewCell.")
        }

        cell.name.text = data[indexPath.row]

        return cell
    }

}
