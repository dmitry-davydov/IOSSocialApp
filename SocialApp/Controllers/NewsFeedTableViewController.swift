//
//  NewsFeedTableViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 30.12.2020.
//

import UIKit
import AsyncDisplayKit


class NewsFeedTableViewController: ASDKViewController<ASTableNode>, ASTableDelegate, ASTableDataSource {
    private var images: [String] = [
        "https://placeimg.com/640/480/any?q=2",
        "https://placeimg.com/640/480/any?q=1",
        "https://placeimg.com/640/480/any?q=3",
    ]
    
    override init() {
        super.init(node: ASTableNode())
        node.delegate = self
        node.dataSource = self
        node.allowsSelection = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        guard images.count > indexPath.row else { return { ASCellNode() }() }
        
        
        let node = ASCellNode(viewControllerBlock: { () -> UIViewController in
            return FriendsTableViewController()
        }, didLoad: nil)
        
        return node
    }
    
//    var tableNode: ASTableNode {
//        node
//    }
    
//    init() {
//        super.init(style: .plain)
//        self.style.width = ASDimension(unit: .fraction, value: 1)
//        self.style.height = ASDimension(unit: .fraction, value: 1)
//        self.style.flexShrink = 1
//    }
//    
    
    
}

