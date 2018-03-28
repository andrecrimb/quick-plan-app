//
//  DesignableNavigationCtrl.swift
//  quickPlan
//
//  Created by André Rosa on 26/03/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableNavigationCtrl: UINavigationController {

    @IBInspectable
    var noBorderBottom: Bool = false {
        didSet{
            setupView(active: self.noBorderBottom)
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView(active: self.noBorderBottom)
    }
    
    func setupView(active: Bool){
        if active{
            // MARK: Remove border in navigationBar
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navigationController?.navigationBar.shadowImage = UIImage()
        }
    }

}
