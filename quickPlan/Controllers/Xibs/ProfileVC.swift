//
//  UserInfoView.swift
//  quickPlan
//
//  Created by André Rosa on 23/03/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

class ProfileVC: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit(){

    }
//
//    var contentView:UIView?
//    @IBInspectable var nibName:String?
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        xibSetup()
//    }
//
//    func xibSetup() {
//        guard let view = loadViewFromNib() else { return }
//        view.frame = bounds
//        view.autoresizingMask =
//            [.flexibleWidth, .flexibleHeight]
//        addSubview(view)
//        contentView = view
//    }
//
//    func loadViewFromNib() -> UIView? {
//        guard let nibName = nibName else { return nil }
//        let bundle = Bundle(for: type(of: self))
//        let nib = UINib(nibName: nibName, bundle: bundle)
//        return nib.instantiate(
//            withOwner: self,
//            options: nil).first as? UIView
//    }
//
    
    
    
    
}
