//
//  LineTextField.swift
//  quickPlan
//
//  Created by André Rosa on 21/03/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

@IBDesignable
class LineTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView(){
        
       
        attributedPlaceholder = NSAttributedString(string:placeholder != nil ? placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])

        
        borderStyle = UITextBorderStyle.none;
        let border = CALayer()
        let width = CGFloat(1.5)
        border.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        border.frame = CGRect(x: 0, y: frame.size.height - width,   width:  frame.size.width, height: frame.size.height)
        
        border.borderWidth = width
        layer.addSublayer(border)
        layer.masksToBounds = true
    }

}
