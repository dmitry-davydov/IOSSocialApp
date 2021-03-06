//
//  AvatarView.swift
//  SocialApp
//
//  Created by Дима Давыдов on 07.10.2020.
//

import UIKit

@IBDesignable class AvatarView: UIView {

    private weak var _image: UIImage?
    
    @IBInspectable weak var image: UIImage? {
        set {
            _image = image
            setImage(newValue!)
        }
        get {
            return _image
        }
    }

    @IBInspectable var shadowRadius: Float = 2
    @IBInspectable var shadowColor: UIColor = .black
    @IBInspectable var shadowOpacity: Float = 0.8

    var imageSuperView: UIView?
    var imageView: UIImageView?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("Alloc \(Date.init())" )
        
        imageSuperView = UIView(frame: self.bounds)
        let layer = CAShapeLayer()
        layer.path = UIBezierPath.init(ovalIn: self.bounds).cgPath
        layer.shadowColor = self.shadowColor.cgColor
        layer.shadowOpacity = self.shadowOpacity
        layer.shadowRadius = CGFloat(self.shadowRadius)
        layer.shadowOffset = .zero
        layer.masksToBounds = false
        imageSuperView!.layer.addSublayer(layer)
        
        
        imageView = UIImageView()
        
        imageView!.clipsToBounds = true
        imageView!.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        imageView!.layer.masksToBounds = true
        imageView!.layer.cornerRadius = CGFloat(self.frame.width) / 2
        
        
        imageSuperView!.addSubview(imageView!)
        
        self.addSubview(imageSuperView!)
    }
    
    deinit {
        imageSuperView = nil
    }
    
    
    
    func setImage(_ image: UIImage) {
        imageView?.image = image
        
    }
    
    func clearSubviews() {
        subviews.forEach({v in
            v.removeFromSuperview()
        })
        
        _image = nil
        imageSuperView = nil
        imageView = nil
    }
    
    func loadFrom(url: URL) {
        let _ = ImageCacheService.shared
            .getImage(by: url)
            .done(on: .main) { [weak self] (img) in
                self?.setImage(img)
            }
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
}
