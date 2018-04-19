//
//  ChannelCell.swift
//  quickPlan
//
//  Created by André Rosa on 27/03/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var unreadChannelView: UIView!
    @IBOutlet weak var unreadChannelLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(channel: Channel){
        let title = channel.channelTitle ?? ""
        channelName.text = title
        unreadChannelView.isHidden = true
        
        var unreadCount = 0
        
        for id in MessageService.instance.unreadChannels {
            if id == channel.id {
                unreadChannelView.isHidden = false
                unreadCount = unreadCount + 1
            }
        }
        unreadChannelLabel.text = "\(unreadCount)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
}
