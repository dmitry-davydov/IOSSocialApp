//
//  LoadingUIButton.swift
//  SocialApp
//
//  Created by Дима Давыдов on 17.10.2020.
//

import Foundation
import UIKit

class LoadingUIButton: UIButton {
    
    private var subview: UIView = UIView()
    private var dots: [UIView] = []

    private func createLoadingView() {
        print("create loading view")
        
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createLoadingView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createLoadingView()
    }
    
    func startLoading(){
        // создадим такую же кнопочку и поместим под основной
        // когда выполнится функция, поменяем местами вьюшки
        
        self.setTitle("", for: .normal)
        
        // выглядит очень костыльно
        self.subview.frame = CGRect(x: 30, y: 5, width: 50, height: self.frame.size.height)
        
        for i in 0..<3 {
        
            let v = UIView(frame: CGRect(x: 3 + (8 * i), y: 10, width: 5, height: 5))
            
            v.layer.backgroundColor = CGColor.init(red: 255, green: 255, blue: 255, alpha: 1)
            v.layer.cornerRadius = 3
            
            let delay = i == 0 ? 0 : TimeInterval(0.1 * Double(i))
            
            UIView.animate(withDuration: 0.4, delay: delay, options: [.autoreverse, .repeat], animations: {
                v.frame = CGRect(x: CGFloat(3 + (8 * i)), y: v.bounds.maxY + 3.5, width: 8, height: 8)
                v.layer.cornerRadius = 5
            }, completion: nil)
            
            dots.append(v)
            
            self.subview.addSubview(v)
        }
        
        
        self.addSubview(self.subview)
    }
    
    
    func endLoading() {
        for v in dots {
            v.layer.removeAllAnimations()
            v.removeFromSuperview()
        }
    }
}