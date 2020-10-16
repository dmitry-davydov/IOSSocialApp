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

class LikeUIButton: UIControl {

    var counterValue: Int = 0;
    
    weak var delegate: LikeUIButtonDelegate?
    
    var isLiked: Bool = false {
        
        didSet {
            
            if let delegate = delegate {
                counterValue = delegate.willUpdateLikeCounter(isLiked: isLiked, currentCounterValue: counterValue)
                print(counterValue)
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
        let defaultImg = UIImage.init(systemName: "suit.heart")
        let selectedImg = UIImage.init(systemName: "suit.heart.fill")
        button.setImage(defaultImg, for: .normal)
        button.setImage(selectedImg, for: .selected)
        
        button.addTarget(self, action: #selector(toggleLike), for: .touchUpInside)
        
        self.addSubview(button)
        
        updateUI()
    
    }
    
    private func updateUI() {
        button.isSelected = isLiked
        button.setTitle("\(counterValue)", for: .selected)
        button.setTitle("\(counterValue)", for: .normal)
    }
    
    @objc private func toggleLike() {
        self.isLiked.toggle()
        self.delegate?.didLikeStateChanged(isLiked: self.isLiked)
    }
    
    override func layoutSubviews() {
        button.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        
    }
}
