//
//  ChatVC.swift
//  quickPlan
//
//  Created by André Rosa on 23/03/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var sendMessageBtn: UIButton!
    @IBOutlet weak var messageTxtBox: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    var textFieldDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        // MARK: Setup Row Height automatically
        // Obs: the number of lines in label has to be 0
        tableView.estimatedRowHeight = 80;
        tableView.rowHeight = UITableViewAutomaticDimension
        
        view.bindToKeyboard()
        configMenuBtn()
        configNavViewUI()
        
        messageTxtBox.delegate = textFieldDelegate
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: Constants.Notifications.UserDataDidChange, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: Constants.Notifications.ChannelSelected, object: nil)
        
        if AuthService.instance.isLoggedIn{
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: Constants.Notifications.UserDataDidChange, object: nil)
            }
        }
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    @objc func userDataDidChange(_ notif: Notification){
        if AuthService.instance.isLoggedIn{
            onLoginGetMessages()
        }
    }
    
    @objc func channelSelected(_ notif: Notification){
        updateWithChannel()
    }
    
    func updateWithChannel(){
        // MARK: If can't find and string set and empty string
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        print(channelName)
        self.navigationItem.title = "#\(channelName)"
        getMessages()
    }
    
    func onLoginGetMessages(){
        MessageService.instance.findAllChannel { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    // Do something because there's no channels
                }
            }
        }
    }
    
    func getMessages(){
        guard let channelId = MessageService.instance.selectedChannel?.id else {return}
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            if success{
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: Set add gesture recognizer to button
    func configMenuBtn(){
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(revealViewController().tapGestureRecognizer())
    }

    
    @IBAction func sendMessagePressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.id else {return}
            guard let message = messageTxtBox.text else {return}
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId) { (success) in
                if success {
                    self.messageTxtBox.text = ""
                }
            }
        }
    }
    
    
    func configNavViewUI(){
        // MARK: Only execute the code if there's a navigation controller
        if navigationController == nil{
            return
        }

        // MARK: Remove border in navigationBar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        // MARK: Create a navView to add to the navigation bar
//        let navView = UIView()
//
//        // MARK: Create the label
//        let label = UILabel()
//        label.text = "  nodeJS"
//        label.sizeToFit()
//        label.center = navView.center
//        label.font = UIFont(name: "Ubuntu-Medium", size: 17.0)
//        label.textColor = #colorLiteral(red: 0.1953743398, green: 0.2127636969, blue: 0.2761407495, alpha: 1)
//        label.textAlignment = NSTextAlignment.center
//
//        // MARK: Create the image view
//        let image = UIImageView()
//        image.image = UIImage(named: "small_logo.png")
//        // MARK: To maintain the image's aspect ratio:
//        let imageAspect = image.image!.size.width/image.image!.size.height
//        // MARK: Setting the image frame so that it's immediately before the text:
//        image.frame = CGRect(x: label.frame.origin.x-label.frame.size.height*imageAspect, y: label.frame.origin.y, width: label.frame.size.height*imageAspect, height: label.frame.size.height)
//        image.contentMode = UIViewContentMode.scaleAspectFit
//
//        // MARK: Add both the label and image view to the navView
//        navView.addSubview(label)
//        navView.addSubview(image)
//
//        // MARK: Set the navigation bar's navigation item's titleView to the navView
//        self.navigationItem.titleView = navView
//
//        // MARK: Set the navView's frame to fit within the titleView
//        navView.sizeToFit()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.MessageCell, for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    
    
}







