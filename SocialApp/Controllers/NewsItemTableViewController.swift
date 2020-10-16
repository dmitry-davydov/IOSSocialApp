//
//  NewsItemTableViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 16.10.2020.
//

import UIKit

class NewsItemTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupNewsDataProvider.instance.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsItemCell", for: indexPath) as? NewsItemTableViewCell else {
            fatalError("Can not cast TableViewCell to NewsItemTableViewCell")
        }

        guard let newsItem = GroupNewsDataProvider.instance[indexPath.row] else {
            fatalError("Can not fetch new item")
        }
    
        cell.prepareCell(newsItem)

        return cell
    }
}
