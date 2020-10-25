//
//  SocialAppPushAnimator.swift
//  SocialApp
//
//  Created by Дима Давыдов on 25.10.2020.
//

import UIKit

class SocialAppPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        destination.view.frame = source.view.frame
        destination.view.frame.origin.x = source.view.frame.size.width - 100
        
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                destination.view.frame.origin.x = 0
                source.view.frame.origin.x *= -1
            })
        }, completion: {(completed) in
            print("Push animation completed")
        })
    }
}
