//
//  NewsItemTableViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 16.10.2020.
//

import UIKit

class NewsItemTableViewController: UITableViewController {
    
    var response: WallGetResponse?
    
    var ownerId: Int! {
        didSet {
            loadWall()
        }
    }
    
    var numbersOfRow: Int {
        return response?.items.count ?? 0
    }
    
    private func loadWall() {
        let request = WallGetRequest(ownerId: -ownerId, domain: nil, offset: 0, count: nil, filter: .all, extended: false)
        let endpoint = Wall()
        endpoint.get(request: request, completion: { response in
            if let err = response.error {
                print(err)
                return
            }
            
            if let wallGetResponse = response.response {
                self.response = wallGetResponse
                self.tableView.reloadData()
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delaysContentTouches = false
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numbersOfRow
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let newsItem = self.response?.items[indexPath.row] else {
            fatalError("Can not fetch new item")
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsItemCell", for: indexPath) as? NewsItemTableViewCell else {
            fatalError("Can not cast TableViewCell to NewsItemTableViewCell")
        }
    
        cell.prepareCell(newsItem)
        
//        cell.newsItemImage.isUserInteractionEnabled = true
//        cell.newsItemImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
//        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsItemCell", for: indexPath) as? NewsItemTableViewCell else {
            fatalError("Can not cast TableViewCell to NewsItemTableViewCell")
        }
        
        cell.clear()
    }
    
    @objc func imageTapped(_ recognizer: UITapGestureRecognizer) {
        print("tapped")
        performSegue(withIdentifier: "ImageSliderSegue", sender: nil)
        
    }
}
