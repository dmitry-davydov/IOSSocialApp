//
//  SocialAppPushAnimator.swift
//  SocialApp
//
//  Created by Дима Давыдов on 25.10.2020.
//

import UIKit

// 
class SocialAppPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        destination.view.frame = source.view.frame
        
        source.view.setAnchorPoint(anchorPoint: CGPoint(x: 1, y: 0))
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.addSubview(source.view)
        
        
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                source.view.transform = source.view.transform.rotated(by: .pi / -2)
                
            })
        }, completion: {(completed) in
            if completed && !transitionContext.transitionWasCancelled {
                source.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(completed && !transitionContext.transitionWasCancelled)

        })
    }
}
