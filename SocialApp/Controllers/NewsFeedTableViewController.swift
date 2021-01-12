//
//  NewsFeedTableViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 30.12.2020.
//

import UIKit

class NewsFeedTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = true
        
        var request = NewsFeedGetRequest(filters: [.photo, .post], returnBanned: false, startTime: nil, endTime: nil, maxPhotos: 5, startFrom: nil, count: 1, userFields: nil, groupFields: nil, section: nil)
        
        let endpoint = NewsFeedApiEndpiont()
        endpoint.get(request: request) { response in
            print(response)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
