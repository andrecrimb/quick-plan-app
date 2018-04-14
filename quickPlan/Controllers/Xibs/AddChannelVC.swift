//
//  AddChannelVC.swift
//  quickPlan
//
//  Created by André Rosa on 11/04/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var nameTxt: LineTextField!
    @IBOutlet weak var channelDesc: LineTextField!
    @IBOutlet var bgView: UIView!
    
    // MARK: Variables
    var textFieldDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
   func setupView(){
        nameTxt.delegate = textFieldDelegate
        channelDesc.delegate = textFieldDelegate
    
        // MARK: Add tap gesture to close modal
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    func cleanFields(){
        nameTxt.text = ""
        channelDesc.text = ""
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChannelPressed(_ sender: Any) {
        guard let channelName = nameTxt.text, nameTxt.text != "" else {return}
        guard let channelDesc = channelDesc.text, nameTxt.text != "" else {return}
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDesc) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
     }
    
}
