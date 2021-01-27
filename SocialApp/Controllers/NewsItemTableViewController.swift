//
//  NewsItemTableViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 16.10.2020.
//

import UIKit

class NewsItemTableViewController: UITableViewController {
    
    private var response: WallGetResponse?
    private var testCell: NewsFeedTableViewCell = NewsFeedTableViewCell()
    private var cellHeightCache: [IndexPath: CGFloat] = [:]
    private let defaultImage: UIImage = UIImage(named: "loading_image")!
    
    var ownerId: Int! {
        didSet {
            loadWall()
        }
    }
    
    var numbersOfRow: Int {
        return response?.items.count ?? 0
    }
    
    private func loadWall() {
        let request = WallGetRequest(ownerId: -ownerId, domain: nil, offset: 0, count: nil, filter: .all, extended: true)
        let endpoint = Wall()
        
        endpoint
            .get(request: request)
            .done(on: .main) { [weak self] (resp) in
                self?.response = resp
                self?.tableView.reloadData()
            }
            .catch { (err) in
                print(err)
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delaysContentTouches = false
        
        tableView.register(NewsFeedTableViewCell.self, forCellReuseIdentifier: "NewsFeedTableViewCell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numbersOfRow
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let height = cellHeightCache[indexPath] {
            return height
        }
        
        configureCell(cell: testCell, cellForRowAt: indexPath)
        let height = testCell.cellHeight
        cellHeightCache[indexPath] = height
        
        return height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedTableViewCell") as? NewsFeedTableViewCell else {
            fatalError("Что то пошло не так")
        }
        
        configureCell(cell: cell, cellForRowAt: indexPath)
        return cell
    }
    
    private func configureCell(cell: NewsFeedTableViewCell, cellForRowAt indexPath: IndexPath) {
        
        guard let newsItemDto = response?.items[indexPath.row] else {
            fatalError("Could not get data")
        }
        
        cell.setAvatarImage(defaultImage)
        
        if let profile = response?.groups.findBy(ownerId: newsItemDto.ownerId) {
            cell.setPostOwner(profile.name)
            
            ImageCacheService.shared
                .getImage(by: URL(string: profile.photo50)!)
                .done(on: .main) { (img) in
                    cell.setAvatarImage(img)
                    cell.setPostOwner(profile.name)
                }
        } else {
            cell.setPostOwner("Unknown")
        }
        
        cell.setdate(TimeInterval(newsItemDto.date))
        cell.setText(text: newsItemDto.text)
        cell.setLike(count: newsItemDto.likes.count, isUserLiked: newsItemDto.likes.userLikes == 1)
        cell.setComments(count: newsItemDto.comments?.count ?? 0)
        cell.setShare(count: newsItemDto.reposts.count)
        cell.setViewsCount(count: newsItemDto.views.count)
    }
    
    @objc func imageTapped(_ recognizer: UITapGestureRecognizer) {
        print("tapped")
        performSegue(withIdentifier: "ImageSliderSegue", sender: nil)
    }
}
