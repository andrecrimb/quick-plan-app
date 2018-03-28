//
//  ChatVC.swift
//  quickPlan
//
//  Created by André Rosa on 23/03/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configMenuBtn()
        configNavViewUI()
    }
    
    
    func configMenuBtn(){
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(revealViewController().tapGestureRecognizer())
    }

    func configNavViewUI(){
        // MARK: Only execute the code if there's a navigation controller
        if navigationController == nil{
            return
        }

        // MARK: Remove border in navigationBar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        // MARK: Create a navView to add to the navigation bar
        let navView = UIView()

        // MARK: Create the label
        let label = UILabel()
        label.text = "  nodeJS"
        label.sizeToFit()
        label.center = navView.center
        label.font = UIFont(name: "Ubuntu-Medium", size: 17.0)
        label.textColor = #colorLiteral(red: 0.1953743398, green: 0.2127636969, blue: 0.2761407495, alpha: 1)
        label.textAlignment = NSTextAlignment.center

        // MARK: Create the image view
        let image = UIImageView()
        image.image = UIImage(named: "small_logo.png")
        // MARK: To maintain the image's aspect ratio:
        let imageAspect = image.image!.size.width/image.image!.size.height
        // MARK: Setting the image frame so that it's immediately before the text:
        image.frame = CGRect(x: label.frame.origin.x-label.frame.size.height*imageAspect, y: label.frame.origin.y, width: label.frame.size.height*imageAspect, height: label.frame.size.height)
        image.contentMode = UIViewContentMode.scaleAspectFit

        // MARK: Add both the label and image view to the navView
        navView.addSubview(label)
        navView.addSubview(image)

        // MARK: Set the navigation bar's navigation item's titleView to the navView
        self.navigationItem.titleView = navView

        // MARK: Set the navView's frame to fit within the titleView
        navView.sizeToFit()
    }
    

}
