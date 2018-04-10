//
//  CreateAccountVC.swift
//  quickPlan
//
//  Created by André Rosa on 28/03/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit
import Foundation

class CreateAccountVC: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var usernameTxt: LineTextField!
    @IBOutlet weak var emailTxt: LineTextField!
    @IBOutlet weak var passwordTxt: LineTextField!
    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var closeViewBtn: UIButton!
    @IBOutlet weak var chooseAvatarBtn: UIButton!
    @IBOutlet weak var chooseBackgroundBtn: UIButton!
    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: Variables
    var avatarName = "user"
    var avatarColor = "[0.5,0.5,0.5,1]"
    var bgColor: UIColor?
    var textFieldDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != ""{
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            if bgColor == nil {
                userImg.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        
        guard let email = emailTxt.text, emailTxt.text != "" else {
            print("Invalid email")
            return
        }
        guard let pass = passwordTxt.text, passwordTxt.text != "" else {
            print("Invalid password")
            return
        }
        guard let name = usernameTxt.text, usernameTxt.text != "" else {
            print("Invalid Name")
            return
        }
        
        loading(isLoading: true)
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("ANDRE: registerUser\n\(success)")
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    print("ANDRE: loginUser!\n\(success)")
                    if success{
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            print("ANDRE: createUser!\n\(success)")
                            if success{
                                self.performSegue(withIdentifier: Constants.Segues.ToChannels, sender: nil)
                                NotificationCenter.default.post(name: Constants.Notifications.NotifUserDataDidChange, object: nil)
                            } else {
                                self.errorMessage()
                            }
                            self.loading(isLoading: false)
                        })
                    }
                    else {
                        self.errorMessage()
                    }
                    self.loading(isLoading: false)
                })
            }
            else {
                self.errorMessage()
            }
            self.loading(isLoading: false)
        }
    }
    
    // MARK: Error message
    func errorMessage(){
        let alert = UIAlertController(title: "Ops...", message: "Username or e-mail already exists", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: Subscribing to keybord notifications to scroll the view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        subscribeToKeyboardNotifications()
    }
    
    // MARK: Unsubscribing to keybord notifications
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: Method that subscribe and unsubscribe to keyboard notifications
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    // MARK: Method that get keyboard height and set contentInset of the scrollview
    @objc func keyboardWillShow(_ notification: Notification){
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    // MARK: Method that set the scrollview contentInset to zero
    @objc func keyboardWillHide(_ notification: Notification){
        view.frame.origin.y = 0
    }
    
    // MARK: Setup All view adjusts before render
    func setupView(){
        createAccountBtn.setTitleColor(UIColor.clear, for: .disabled)
        usernameTxt.delegate = textFieldDelegate
        passwordTxt.delegate = textFieldDelegate
        emailTxt.delegate = textFieldDelegate
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    
    // MARK: Dismiss keyboard when user tap anywhere
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    // MARK: If is loading disable actions and fields and start spinner
    func loading(isLoading: Bool){
        usernameTxt.isEnabled = !isLoading
        emailTxt.isEnabled = !isLoading
        passwordTxt.isEnabled = !isLoading
        chooseAvatarBtn.isEnabled = !isLoading
        chooseBackgroundBtn.isEnabled = !isLoading
        closeViewBtn.isEnabled = !isLoading
        createAccountBtn.isEnabled = !isLoading
        if isLoading {
            spinner.startAnimating()
        } else {
            spinner.stopAnimating()
        }
    }
    
    // MARK: Deals with avatar random color
    @IBAction func pickBGColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        avatarColor = "[\(r),\(g),\(b),1]"
        UIView.animate(withDuration: 0.2){
            self.userImg.backgroundColor = self.bgColor
        }

    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
           performSegue(withIdentifier: Constants.Segues.toAvatarPicker, sender: nil)
    }
    
    
    @IBAction func dismissView(){
        performSegue(withIdentifier: Constants.Segues.Unwind, sender: nil)
    }

}
