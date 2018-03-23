//
//  RoundedButton.swift
//  quickPlan
//
//  Created by André Rosa on 22/03/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableButton: UIButton {
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            
            layer.cornerRadius = newValue <= 0 ? 7.0 : newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
