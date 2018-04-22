//
//  UserProfileVC.swift
//  quickPlan
//
//  Created by André Rosa on 08/04/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

class UserProfileVC: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var mainActionBtn: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    
    // MARK: Variables
    var isEditingProfile: Bool = false
    var textFieldDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        mainActionBtn.setTitleColor(UIColor.clear, for: .disabled)
        
        // MARK: Setting up textfield delegate
        userEmail.delegate = textFieldDelegate
        userName.delegate = textFieldDelegate
        
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        profileImage.image = UIImage(named: UserDataService.instance.avatarName)
        profileImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        
        // MARK: Add tap gesture to close modal 
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(UserProfileVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Changes button main action whether editing
    @IBAction func mainActionPressed(_ sender: Any) {
        if isEditingProfile {
            guard let name = userName.text, userName.text != "" else {return}
            guard let email = userEmail.text, userEmail.text != "" else {return}
            
            loading(isLoading: true)
            AuthService.instance.updateUser(name: name, email: email) { (success) in
                if success {
                    NotificationCenter.default.post(name: Constants.Notifications.UserDataDidChange, object: nil)
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.errorMessage()
                }
                self.loading(isLoading: false)
            }
        } else {
            UserDataService.instance.logoutUser()
            NotificationCenter.default.post(name: Constants.Notifications.UserDataDidChange, object: nil)
            dismiss(animated: true, completion: nil)
        }
    }
  
    func editingProfile(editing: Bool){
        isEditingProfile = true
        mainActionBtn.setTitle(editing ? "Save" : "Logout", for: .normal)
    }
    
    @IBAction func tapUserNameToEdit(_ sender: Any) {
        editingProfile(editing: true)
    }
    
    @IBAction func tapUserEmailToEdit(_ sender: Any) {
        editingProfile(editing: true)
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        editingProfile(editing: false)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: If is loading disable actions and fields and start spinner
    func loading(isLoading: Bool){
        userEmail.isEnabled = !isLoading
        userName.isEnabled = !isLoading
        mainActionBtn.isEnabled = !isLoading
       
        if isLoading {
            spinner.startAnimating()
        } else {
            spinner.stopAnimating()
        }
    }
    
    // MARK: Error message
    func errorMessage(){
        let alert = UIAlertController(title: "Ops...", message: "Something went wrong", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }

}
