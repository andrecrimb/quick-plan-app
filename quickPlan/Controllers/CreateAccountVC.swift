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

    @IBOutlet weak var usernameTxt: LineTextField!
    @IBOutlet weak var emailTxt: LineTextField!
    @IBOutlet weak var passwordTxt: LineTextField!
    @IBOutlet weak var userImg: UIImage!
    
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
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("ANDRE: Registred user!")
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success{
                        print("ANDRE: Logged in user! \(AuthService.instance.authToken)")
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
        dismiss(animated: true, completion: nil)
    }

}
