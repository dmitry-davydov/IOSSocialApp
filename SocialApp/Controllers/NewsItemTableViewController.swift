//
//  NewsItemTableViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 16.10.2020.
//

import UIKit
import PromiseKit

class NewsItemTableViewController: UITableViewController, UITableViewDataSourcePrefetching, CellHeightChangedDelegate {
    private var response: WallGetResponse = WallGetResponse()
    private var testCell: NewsFeedTableViewCell = NewsFeedTableViewCell()
    private var cellHeightCache: [IndexPath: CGFloat] = [:]
    private let defaultImage: UIImage = UIImage(named: "loading_image")!
    private var isLoading: Bool = false
    private let prefetchRowsLeft = 2
    
    var ownerId: Int! {
        didSet {
            loadWall().ensure(on: .main) {[weak self] in
                self?.tableView.reloadData()
            }.catch { (err) in
                debugPrint(err.localizedDescription)
            }
        }
    }
    
    var numbersOfRow: Int {
        return response.items.count
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .gray
        refreshControl?.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }
    
    @objc func refreshAction() {
        refreshControl?.beginRefreshing()
        // получить первую запись
        
        // отправить запрос на сервер
        loadWall().ensure(on: .main) { [weak self] in
            self?.cellHeightCache = [:]
            self?.refreshControl?.endRefreshing()
            
        }
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({$0.row}).max() else {
            return
        }
        
        print("[prefetch] indexPaths count: \(indexPaths.count)")
        
        let maxRow = response.items.count - prefetchRowsLeft
        print("[prefetch] maxSection: \(maxSection); maxRow: \(maxRow); prefetch rows: \(maxRow)")
        if maxSection <= maxRow || isLoading { return }
        
        print("[prefetch] prefetching")
        loadWall(offset: response.items.count).catch { (err) in
            debugPrint(err.localizedDescription)
        }
    }
    
    private func loadWall(offset: Int = 0) -> Promise<Void> {
        print("[prefetch] offset: \(offset)")
        let request = WallGetRequest(ownerId: -ownerId, domain: nil, offset: offset, count: 20, filter: .all, extended: true)
        let endpoint = Wall()
        isLoading = true
        return endpoint
            .get(request: request)
            .done(on: .main) { [weak self] (resp) in
                
                guard let self = self else { return }
                
                
                if offset == 0 {
                    self.response = resp
                    self.tableView.reloadData()
                    
                    return
                }
                
                
                
                print("[prefetch] offset \(offset)")
                
                self.response.appendData(response: resp)
                self.tableView.insertRows(at: (offset..<self.response.items.count).map({IndexPath(row: $0, section: 0)}), with: .automatic)
                
            }
            .ensure { [weak self] in
                self?.isLoading = false
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delaysContentTouches = false
        tableView.prefetchDataSource = self
        tableView.register(NewsFeedTableViewCell.self, forCellReuseIdentifier: "NewsFeedTableViewCell")
        tableView.isUserInteractionEnabled = true
        tableView.allowsSelection = false
//        tableView.estimatedRowHeight = UITableView.automaticDimension
        setupRefreshControl()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numbersOfRow
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("heightForRowAt indexPath: \(indexPath) ")
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
        cell.indexPath = indexPath
        return cell
    }
    
    private func configureCell(cell: NewsFeedTableViewCell, cellForRowAt indexPath: IndexPath) {
        
        let newsItemDto = response.items[indexPath.row]
        
        cell.setAvatarImage(defaultImage)
        cell.cellHeightChangedDelegate = self
        if let profile = response.groups.findBy(ownerId: newsItemDto.ownerId) {
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
    
    func cellHeightWillChange(at indexPath: IndexPath) {


    }
    
    func cellHeightDidChanged(newHeight: CGFloat, at indexPath: IndexPath) {
        tableView.beginUpdates()
        print("new cell height \(newHeight) for indexPath: \(indexPath)")
        
        cellHeightCache[indexPath] = newHeight
//        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
}
