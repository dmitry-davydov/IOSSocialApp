//
//  UserCollectionViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 06.10.2020.
//

import UIKit

class UserCollectionViewController: UICollectionViewController {

    var user: UserDto!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.delegate = self
//        interactiveTransition.viewController = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userImageCell", for: indexPath) as! UserCollectionViewCell
        
        if let userPhoto = user.photo100 {
            cell.avatarView.loadFrom(url: URL(string: userPhoto)!)
        }
        
        
        
        return cell
    }
}


