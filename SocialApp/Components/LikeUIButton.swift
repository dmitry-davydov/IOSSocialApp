//
//  LikeUIButton.swift
//  SocialApp
//
//  Created by Дима Давыдов on 10.10.2020.
//

import UIKit

class LikeUIButton: UIControl {

    var counterValue: Int = 0;
    private var isLiked: Bool = false {
        didSet {
            
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
        button.clipsToBounds = true
        
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
        print("toggleLike")
        self.isLiked.toggle()
    }
    
    override func layoutSubviews() {
        button.frame = self.bounds
    }
}
