//
//  SocialAppNavigationController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 26.10.2020.
//

import UIKit

class SocialAppNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    var interactiveTransition = SocialAppInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
            return SocialAppPopAnimator()
        }
        
        if operation == .push {
            if viewControllers.first != toVC {
                interactiveTransition.viewController = toVC
            }
            return SocialAppPushAnimator()
        }
        
        return nil
    }
}
