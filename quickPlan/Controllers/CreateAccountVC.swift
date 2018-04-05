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
    @IBOutlet weak var userImg: UIImage!
    
    // MARK: Variables
    var avatarName = "user"
    var avatarColor = "[0.5,0.5,0.5,1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let email = emailTxt.text, emailTxt.text != "" else {
            print("Invalid email)")
            return
        }
        guard let pass = passwordTxt.text, passwordTxt.text != "" else {
            print("Invalid passworf")
            return
        }
        guard let name = usernameTxt.text, usernameTxt.text != "" else {
            print("Invalid Name")
            return
        }
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("ANDRE: Registred user!")
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success{
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success{
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: Constants.Segues.ToChannels, sender: nil)
                            }
                            
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
        
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        
    }
    
    
    @IBAction func dismissView(){
        performSegue(withIdentifier: Constants.Segues.Unwind, sender: nil)
    }

}
