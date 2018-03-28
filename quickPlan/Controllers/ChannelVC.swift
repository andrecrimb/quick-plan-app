//
//  ChannelVC.swift
//  quickPlan
//
//  Created by André Rosa on 23/03/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        revealViewController().rearViewRevealWidth = view.frame.size.width - 60
        
    }
    override func viewDidAppear(_ animated: Bool) {
        self.view.frame.size.width = self.revealViewController().rearViewRevealWidth
    }
    
    
    
}
