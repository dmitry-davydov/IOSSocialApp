//
//  NewsFeedTableViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 30.12.2020.
//

import UIKit

class NewsFeedTableViewController: UITableViewController {

    var testCell: NewsFeedTableViewCell = NewsFeedTableViewCell()
    private var cellHeightCache: [IndexPath: CGFloat] = [:]
    private let defaultImage: UIImage = UIImage(named: "loading_image")!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = true
        
//        var request = NewsFeedGetRequest(filters: [.photo, .post], returnBanned: false, startTime: nil, endTime: nil, maxPhotos: 5, startFrom: nil, count: 1, userFields: nil, groupFields: nil, section: nil)
        
//        let endpoint = NewsFeedApiEndpiont()
//        endpoint.get(request: request) { response in
//            print(response)
//        }
        
        tableView.register(NewsFeedTableViewCell.self, forCellReuseIdentifier: "NewsFeedTableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        configureCell(cell: testCell, cellForRowAt: indexPath)
        
        return testCell.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedTableViewCell") as? NewsFeedTableViewCell else {
            fatalError("Что то пошло не так")
        }
        
        configureCell(cell: cell, cellForRowAt: indexPath)
        return cell
    }
    
    private func configureCell(cell: NewsFeedTableViewCell, cellForRowAt indexPath: IndexPath) {
        cell.setAvatarImage(UIImage(named: "test")!)
        cell.setPostOwner("test owner name")
        cell.setdate(TimeInterval(1611401093))
        cell.setText(text: "Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text Test text ")
        cell.setLike(count: 10, isUserLiked: true)
        cell.setComments(count: 29)
        cell.setShare(count: 50)
        cell.setViewsCount(count: 100)
    }
    
}
