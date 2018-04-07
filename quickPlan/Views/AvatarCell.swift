//
//  AvatarCell.swift
//  quickPlan
//
//  Created by André Rosa on 07/04/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

enum AvatarType{
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var avatarContainerView: DesinableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    func configureCell(index: Int, type: AvatarType){
        if type == AvatarType.dark{
            avatarImage.image = UIImage(named: "dark\(index)")
            avatarContainerView.layer.backgroundColor = UIColor.lightGray.cgColor
        } else {
            avatarImage.image = UIImage(named: "light\(index)")
            avatarContainerView.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
    func setupView(){
        avatarContainerView.layer.backgroundColor = UIColor.lightGray.cgColor
    }
    
}
