//
//  NavigationTitleView.swift
//  quickPlan
//
//  Created by André Rosa on 13/04/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

class NavigationTitleView: UIView {
    
    // MARK: Outlets
    @IBOutlet weak var navTitle: UILabel!
    @IBOutlet var contentView: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView(){
        Bundle.main.loadNibNamed("NavigationTitleView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
}
