//
//  UserCollectionViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 06.10.2020.
//

import UIKit

class UserCollectionViewController: UICollectionViewController {

    var userImage: UIImage?
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userImageCell", for: indexPath) as! UserCollectionViewCell
        
        cell.avatarView.image = userImage!
        
        return cell
    }
}
