//
//  CustomImage.swift
//  quickPlan
//
//  Created by André Rosa on 22/03/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

@IBDesignable
class CustomImage: UIImageView {
    
    @IBInspectable
    var customImage: Bool = false{
        didSet{
            setupView(active: self.customImage)
        }
    }
    
    func setupView(active: Bool){
        if active{
            layer.cornerRadius = 16
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 1, height: 1)  //Here you control x and y
            layer.shadowOpacity = 0.3
            layer.shadowRadius = 6 //Here your control your blur
            layer.masksToBounds =  false
            layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 16).cgPath
        }
    }
    
}
