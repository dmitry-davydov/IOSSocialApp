//
//  ImageViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 22.10.2020.
//

import UIKit

class ImageViewController: UIViewController {

    private var animation = UIViewPropertyAnimator()
    var imageViewList: [UIImageView] = []
    private var currentImagePosition = 0
    private var initialGuesturePoint: CGPoint?
    
    enum AnimateTo {
        case left, right
    }
    
    private func createImageView(_ image: UIImage) {
        
        let frame = CGRect(x: imageViewList.count == 0 ? 0 : self.view.frame.size.width, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height)
        
        let imageView = UIImageView(frame: frame)
        imageView.image = image
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.autoresizesSubviews = true
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        
        imageViewList.append(imageView)
        
        self.view.addSubview(imageView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.alpha = 0
        self.view.backgroundColor = .black
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
        self.view.addGestureRecognizer(panGestureRecognizer)
        
        addImages()
    }
    
    private func isSwipingLeft() -> Bool {
        let currentImageView = self.imageViewList[self.currentImagePosition]
        return currentImageView.frame.origin.x > self.view.frame.size.width / 2
    }
    private func isSwipingRight() -> Bool {
        let currentImageView = self.imageViewList[self.currentImagePosition]
        return currentImageView.frame.origin.x < (self.view.frame.size.width / 2) * -1
    }
    
    private func hasImageOnTheLeft() -> Bool {
        return currentImagePosition > 0
    }
    
    private func hasImageOnTheRight() -> Bool {
        return currentImagePosition < imageViewList.count - 1
    }
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            self.initialGuesturePoint = recognizer.translation(in: self.view)
            UIView.animate(withDuration: 0.3, animations: {
                let currentImageView = self.imageViewList[self.currentImagePosition]
                currentImageView.transform = currentImageView.transform.scaledBy(x: 0.8, y: 0.8)
                currentImageView.alpha = 0.6
            })
        case .changed:
            let currentImageView = self.imageViewList[self.currentImagePosition]
            let translation = recognizer.translation(in: self.view)
            
            currentImageView.frame.origin.x = initialGuesturePoint!.x + (translation.x * 1.6)
            
        case .ended:

            if isSwipingLeft() && hasImageOnTheLeft() {
                animate(.left)
                return
            }
            
            if isSwipingRight() && hasImageOnTheRight() {
                animate(.right)
                return
            }
            
            // default animation
            
            animation = UIViewPropertyAnimator(duration: 0.1, curve: .easeInOut, animations: {
                let currentImageView = self.imageViewList[self.currentImagePosition]
                currentImageView.alpha = 1
                currentImageView.transform = .identity
                currentImageView.frame.origin.x = 0
            })
            animation.startAnimation()
            
        default:
            print("1")
        }
    }
    
    func animate(_ to: AnimateTo) {
        
        let currentImageView = self.imageViewList[self.currentImagePosition]
        
        var currentViewTargetXPosition: CGFloat
        var nextView: UIImageView
        var nextImagePosition = currentImagePosition
        var nextViewInitialXPosition: CGFloat = 0
        
        switch to {
        case .left:
            currentViewTargetXPosition = self.view.frame.size.width
            nextViewInitialXPosition = self.view.frame.size.width * -1
            nextView = self.imageViewList[self.currentImagePosition - 1]
            nextImagePosition -= 1
        case .right:
            currentViewTargetXPosition = self.view.frame.size.width * -1
            nextViewInitialXPosition = self.view.frame.size.width
            nextView = self.imageViewList[self.currentImagePosition + 1]
            nextImagePosition += 1
        }
        
        nextView.transform = .identity
        nextView.frame.origin.x = nextViewInitialXPosition
        
        UIView.animateKeyframes(withDuration: 0.7, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                currentImageView.frame.origin.x = currentViewTargetXPosition
            })

            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                nextView.frame.origin.x = 0
                nextView.alpha = 1
            })
        }, completion: {[unowned self] (_) in
            self.currentImagePosition = nextImagePosition
        })
    }
    
    func addImages() {
        
        let url = URL.init(string: "https://picsum.photos/600")!
        
        for _ in 0..<5 {
            
            DispatchQueue.global(qos: .userInteractive).async { [unowned self] in
                
                let imageData = try? Data(contentsOf: url)
                
                DispatchQueue.main.async { [unowned self] in
                    self.createImageView(UIImage(data: imageData!)!)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for v in imageViewList {
            v.removeFromSuperview()
        }
        self.tabBarController?.tabBar.alpha = 1
        imageViewList = []
    }

}
