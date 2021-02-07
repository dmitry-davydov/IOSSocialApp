//
//  UserCollectionViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 06.10.2020.
//

import UIKit
import AsyncDisplayKit

class UserCollectionViewController: ASDKViewController<ASTableNode> {

    var user: FriendsRealmModel!
    
    
    init(userModel: FriendsRealmModel) {
        user = userModel
        
        super.init(node: ASTableNode(style: .plain))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.node.delegate = self
        self.node.dataSource = self
        node.view.allowsSelection = false
        node.view.backgroundColor = .white
        
    }
    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userImageCell", for: indexPath) as! UserCollectionViewCell
//        cell.avatarView.loadFrom(url: URL(string: user.avatar)!)
//
//        return cell
//    }
}

extension UserCollectionViewController: ASTableDelegate, ASTableDataSource {
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let userId = UserID(self.user.userId)
        
        let vc = ASCellNode(viewControllerBlock: { () -> UIViewController in
            let vc = AlbumCollectionViewController(userId: userId)
            vc.fetchUserAlbums()
            
            return vc
        }, didLoad: nil)
        
        let size = CGSize(width: node.bounds.size.width, height: node.bounds.size.height)
        vc.style.preferredSize = size
        
        return {
            return vc
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
}
