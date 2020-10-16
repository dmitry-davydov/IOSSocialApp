//
//  LoginViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 30.09.2020.
//

import UIKit

class LoginViewController: UIViewController {

    var loginService: LoginService?
    var isPerformingLoggingIn: Bool = false
    var timer: Timer?
    var originalButtonText: String?
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global(qos: .background).async {
            self.loginService = LoginService()
        }
        
        self.prepareUI()
        
        username.text = "1"
        password.text = "1"
        
        scrollView?.contentInset = UIEdgeInsets.zero
        scrollView?.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    private func prepareUI() {
        self.scrollView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard)))
        self.loginButtonOutlet.layer.cornerRadius = 5
        self.originalButtonText = self.loginButtonOutlet.currentTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(notification: Notification) {

        guard let sv = self.scrollView else {return}
        
        // ревью такое проходит?
        // выделил память только 1 раз?
        let keyboardHeight = ((notification.userInfo! as NSDictionary).value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size.height

        // автоматически скролим так, чтобы инпуты отображались по середине
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        
        sv.contentInset = contentInsets
        sv.scrollIndicatorInsets = contentInsets
        sv.setContentOffset(CGPoint(x: 0, y: contentInsets.bottom / 2), animated: true)
        
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        scrollView?.contentInset = UIEdgeInsets.zero
        scrollView?.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    @IBAction func onSubmitTouchUpInside(_ sender: UIButton) {
        
        self.timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(self.login), userInfo: nil, repeats: false)
        DispatchQueue.main.async {
            sender.isEnabled = false
            sender.setTitle("Loading", for: .normal)
        }
    }
    
    @objc func login() {
        self.timer?.invalidate()
        
        DispatchQueue.main.async {
            self.loginButtonOutlet.isEnabled = true
            self.loginButtonOutlet.setTitle(self.originalButtonText, for: .normal)
        }
        
        guard let usernameText = username.text else { alertWrongLoginOrPassword(); return ;}
        guard let passwordText = password.text else { alertWrongLoginOrPassword(); return ;}
        
        if loginService!.performLogin(username: usernameText, password: passwordText) {
            navigateToEntryPoint()
            return
        }
        
        
    }
    
    private func alertWrongLoginOrPassword() {
        let alert = UIAlertController(title: "Error", message: "Login or Password invalid", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func navigateToEntryPoint() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabViewController") as! TabViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
