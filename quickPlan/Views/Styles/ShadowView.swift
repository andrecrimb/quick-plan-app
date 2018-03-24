//
//  CustomImage.swift
//  quickPlan
//
//  Created by André Rosa on 22/03/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

@IBDesignable
class ShadowView: UIView {
    
    @IBInspectable
    var shadow: Bool = false{
        didSet{
            setupView(active: self.shadow)
        }
    }
    
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView(active: shadow)
    }
    
    func setupView(active: Bool){
        if active{
            layer.shadowColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
            layer.masksToBounds = false
            layer.shadowOffset = CGSize(width: 1, height: 2)  //Here you control x and y
            layer.shadowOpacity = 0.13
            layer.shadowRadius = 6 //Here your control your blur
            layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 14).cgPath
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView(active: shadow)
    }
}
