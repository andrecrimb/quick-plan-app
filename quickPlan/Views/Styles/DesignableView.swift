//
//  DesignableView.swift
//  quickPlan
//
//  Created by André Rosa on 23/03/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

@IBDesignable
class DesinableView: UIView {
}

@IBDesignable
class DesignableImage: UIImageView {
}

@IBDesignable
class DesignableButton: UIButton {
}

extension UIView {

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    
}
