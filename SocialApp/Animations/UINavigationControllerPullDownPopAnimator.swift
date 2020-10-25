//
//  UINavigationControllerPullDownPopAnimator.swift
//  SocialApp
//
//  Created by Дима Давыдов on 25.10.2020.
//

import UIKit

class UINavigationControllerPullDownPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        destination.view.frame = CGRect(x: 0, y: source.view.frame.height * -1, width: source.view.frame.width, height: source.view.frame.height)
        
        transitionContext.containerView.addSubview(destination.view)
        
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                destination.view.frame = CGRect(x: 0, y: 0, width: source.view.frame.width, height: source.view.frame.height)
                
                source.view.frame = CGRect(x: source.view.frame.width, y: 0, width: source.view.frame.width, height: source.view.frame.height)
            })
        }, completion: {(completed) in
            transitionContext.completeTransition(completed && !transitionContext.transitionWasCancelled)
        })
    }
    
    
}
