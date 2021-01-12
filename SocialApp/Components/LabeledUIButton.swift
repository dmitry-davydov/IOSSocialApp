//
//  LabeledUIButton.swift
//  SocialApp
//
//  Created by Дима Давыдов on 30.12.2020.
//

import UIKit

protocol LabeledUIButtonDelegate: class {
    func onButtonClick()
}

@IBDesignable
class LabeledUIButton: UIControl {

    @IBOutlet weak var view: UIButton!
    
    @IBInspectable var buttonImage: UIImage? {
        get {
            return view?.image(for: .normal)
        }
        set {
            view.setImage(newValue, for: .normal)
        }
    }
    
    @IBInspectable var buttonTextColor: UIColor? {
        get {
            return view.titleColor(for: .normal)
        }
        set {
            view.setTitleColor(newValue, for: .normal)
        }
    }
    
    weak var delegate: LabeledUIButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    private func setup() {
        view = loadViewFromNib() as! UIButton?
        view.frame = bounds
        
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIButton
        
        return view
    }
}
