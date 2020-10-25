//
//  UserCollectionViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 06.10.2020.
//

import UIKit

class UserCollectionViewController: UICollectionViewController, UINavigationControllerDelegate {

    var userImage: UIImage?
    var interactiveTransition = SocialAppInteractiveTransition()
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.delegate = self
        interactiveTransition.viewController = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userImageCell", for: indexPath) as! UserCollectionViewCell
        
        cell.avatarView.image = userImage!
        
        return cell
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
            return UINavigationControllerPullDownPopAnimator()
        }
                
        return nil
    }
}


