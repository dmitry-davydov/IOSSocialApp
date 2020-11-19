//
//  ScaleViewCellAnimationDelegate.swift
//  SocialApp
//
//  Created by Дима Давыдов on 21.10.2020.
//

import UIKit


class ScaleViewCellAnimation {
    
    weak var animationView: UIView?
    
    func startInAnimation(complete: @escaping () -> Void) {
        
        guard let animationView = self.animationView else { return }
        
        UIView.animate(withDuration: 0.1, delay: 0, options: [.beginFromCurrentState], animations: {
            animationView.transform = animationView.transform.scaledBy(x: 0.9, y: 0.9)
        }, completion: {(_) in
            complete()
        })
    }
    
    func startOutAnimation(complete: @escaping () -> Void) {
        guard let animationView = self.animationView else { return }
        
        UIView.animate(withDuration: 0.1, delay: 0, options: [.beginFromCurrentState], animations: {
            animationView.transform = .identity
        }, completion: {(_) in
            complete()
        })
    }
   
}
