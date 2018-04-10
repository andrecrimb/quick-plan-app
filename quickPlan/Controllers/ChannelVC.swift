//
//  ChannelVC.swift
//  quickPlan
//
//  Created by André Rosa on 23/03/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        getUserInfo()
    }
    
    func setupView(){
        revealViewController().rearViewRevealWidth = view.frame.size.width - 60
        getUserInfo()
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: Constants.Notifications.NotifUserDataDidChange, object: nil)
    }
    
    @objc func userDataDidChange(_ notif: Notification){
        getUserInfo()
    }
    
    
    @IBAction func profileViewPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            let profile = UserProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        }
    }
    
    func getUserInfo(){
        if AuthService.instance.isLoggedIn {
            userNameLabel.text = UserDataService.instance.name
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            userImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            // MARK: Dismiss all views to root view controller
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
                (appDelegate.window?.rootViewController as? UINavigationController)?.popToRootViewController(animated: true)
            }

            userNameLabel.text = ""
            userImage.image =  #imageLiteral(resourceName: "user")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.frame.size.width = self.revealViewController().rearViewRevealWidth
    }
    
    
    
}
