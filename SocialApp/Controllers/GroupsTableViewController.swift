//
//  GlobalGroupsTableViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 02.10.2020.
//

import UIKit

class GroupsTableViewController: UITableViewController {

    let ownGroupsDataProvider: MemoryDataProvider<Group> = MemoryDataProvider<Group>()
    let globalGroupsDataProvider: MemoryDataProvider<Group> = MemoryDataProvider<Group>()
    
    let SECTION_OWN_GROUPS = 0
    let SECTION_GLOBAL_GROUPS = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadFakeData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func loadFakeData() {
        _ = ownGroupsDataProvider
            .addDataItem(item: Group(gid: UUID.init().uuidString, name: "OwnGroup1", image: "https://picsum.photos/200"))
            .addDataItem(item: Group(gid: UUID.init().uuidString, name: "OwnGroup2", image: "https://picsum.photos/200"))
            .addDataItem(item: Group(gid: UUID.init().uuidString, name: "OwnGroup3", image: "https://picsum.photos/200"))
            .addDataItem(item: Group(gid: UUID.init().uuidString, name: "OwnGroup4", image: "https://picsum.photos/200"))
            .addDataItem(item: Group(gid: UUID.init().uuidString, name: "OwnGroup5", image: "https://picsum.photos/200"))
            .addDataItem(item: Group(gid: UUID.init().uuidString, name: "OwnGroup6", image: "https://picsum.photos/200"))
        
        _ = globalGroupsDataProvider
            .addDataItem(item: Group(gid: UUID.init().uuidString, name: "GlobalGroup100", image: "https://picsum.photos/200"))
            .addDataItem(item: Group(gid: UUID.init().uuidString, name: "GlobalGroup101", image: "https://picsum.photos/200"))
            .addDataItem(item: Group(gid: UUID.init().uuidString, name: "GlobalGroup102", image: "https://picsum.photos/200"))
            .addDataItem(item: Group(gid: UUID.init().uuidString, name: "GlobalGroup103", image: "https://picsum.photos/200"))
            .addDataItem(item: Group(gid: UUID.init().uuidString, name: "GlobalGroup104", image: "https://picsum.photos/200"))
            .addDataItem(item: Group(gid: UUID.init().uuidString, name: "GlobalGroup105", image: "https://picsum.photos/200"))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case SECTION_GLOBAL_GROUPS:
            return globalGroupsDataProvider.count
        case SECTION_OWN_GROUPS:
            return ownGroupsDataProvider.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var item: Group!
        var cell: GroupCell
        
        switch indexPath.section {
        case SECTION_OWN_GROUPS:
            item = ownGroupsDataProvider[indexPath.row]
        case SECTION_GLOBAL_GROUPS:
            item = globalGroupsDataProvider[indexPath.row]
        default:
            fatalError("Out of sections")
        }
        
        cell = (tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell)!
        
        cell.name.text = item.name
        cell.avatar.loadFrom(url: item.getImageURL())

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case SECTION_OWN_GROUPS:
            return "Your groups"
        case SECTION_GLOBAL_GROUPS:
            return "Global"
        default:
            return "Unknown"
        }
    }

}
