//
//  LikeUIButton.swift
//  SocialApp
//
//  Created by Дима Давыдов on 10.10.2020.
//

import UIKit

protocol LikeUIButtonDelegate: class {
    func didLikeStateChanged(isLiked: Bool)
    func willUpdateLikeCounter(isLiked: Bool, currentCounterValue: Int) -> Int
}

extension LikeUIButtonDelegate {
    func didLikeStateChanged(isLiked: Bool) {}
    func willUpdateLikeCounter(isLiked: Bool, currentCounterValue: Int) -> Int {
        return isLiked
            ? currentCounterValue + 1
            : currentCounterValue - 1
    }
}

@IBDesignable
class LikeUIButton: UIControl {

    var counterValue: Int = 0;
    
    weak var delegate: LikeUIButtonDelegate?
    
    var defaultImg = UIImage.init(systemName: "suit.heart")
    var selectedImg = UIImage.init(systemName: "suit.heart.fill")
    
    var isLiked: Bool = false {
        
        didSet {
            
            if let delegate = delegate {
                counterValue = delegate.willUpdateLikeCounter(isLiked: isLiked, currentCounterValue: counterValue)
                updateUI()
                return
            }
            
            if isLiked {
                counterValue += 1
            } else {
                counterValue -= 1
            }
            
            updateUI()
        }
    }
    
    private var button: UIButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    private func setupView() {
        button = UIButton()
        button.frame = self.frame
        button.setTitleColor(UIColor.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.setImage(defaultImg, for: .normal)
        
        button.addTarget(self, action: #selector(toggleLike), for: .touchUpInside)
        
        self.addSubview(button)
        
        updateUI()
    
    }
    
    private func updateUI() {
        button.setTitle("\(counterValue)", for: .normal)
    }
    
    @objc private func toggleLike() {
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveLinear], animations: {
            self.button.alpha = 0
            self.button.imageView?.transform = CGAffineTransform.init(rotationAngle: 180)
        }, completion: {(_) in
            self.isLiked.toggle()
            self.button.imageView?.transform = .identity
            self.button.setImage(self.isLiked ? self.selectedImg : self.defaultImg, for: .normal)
            self.button.alpha = 1
            self.button.setTitle("\(self.counterValue)", for: .normal)
        })
        
        self.delegate?.didLikeStateChanged(isLiked: self.isLiked)
    }
    
    override func layoutSubviews() {
        button.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        
    }
}
