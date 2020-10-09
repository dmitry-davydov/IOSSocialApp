//
//  AvatarView.swift
//  SocialApp
//
//  Created by Дима Давыдов on 07.10.2020.
//

import UIKit

@IBDesignable class AvatarView: UIView {

    private var _image: UIImage?
    
    @IBInspectable var image: UIImage? {
        set {
            setImage(newValue!)
        }
        get {
            return _image
        }
    }

    @IBInspectable var shadowRadius: Float = 2
    @IBInspectable var shadowColor: UIColor = .black
    @IBInspectable var shadowOpacity: Float = 0.8

    func setImage(_ image: UIImage) {
        
        self._image = image
        
        let imageSuperView = UIView(frame: self.bounds)
        let layer = CAShapeLayer()
        layer.path = UIBezierPath.init(ovalIn: self.bounds).cgPath
        layer.shadowColor = self.shadowColor.cgColor
        layer.shadowOpacity = self.shadowOpacity
        layer.shadowRadius = CGFloat(self.shadowRadius)
        layer.shadowOffset = .zero
        layer.masksToBounds = false
        imageSuperView.layer.addSublayer(layer)
        
        
        let iView = UIImageView(image: image)
        iView.clipsToBounds = true
        iView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        iView.layer.masksToBounds = true
        iView.layer.cornerRadius = CGFloat(self.frame.width) / 2
        
        
        imageSuperView.addSubview(iView)
        
        self.addSubview(imageSuperView)
    }
    
    func clearSubviews() {
        subviews.forEach({v in
            v.removeFromSuperview()
        })
        _image = nil
        
        print("removed")
    }
    
    func loadFrom(url: URL) {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            
            let imageData = try? Data(contentsOf: url)
            
            DispatchQueue.main.async { [weak self] in
                self?.setImage(UIImage(data: imageData!)!)
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
}
