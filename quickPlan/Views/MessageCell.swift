//
//  MessageCell.swift
//  quickPlan
//
//  Created by André Rosa on 16/04/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    // MARK: Outlets
    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageBodyLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(message: Message){
        messageBodyLabel.text = message.message
        userNameLabel.text = message.userName
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        
    }

}
