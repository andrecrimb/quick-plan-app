//
//  ViewKeyboardHandler.swift
//  quickPlan
//
//  Created by André Rosa on 07/04/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import Foundation

extension UIViewController{
    func getKeyboardHeight(_ notification: Notification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func unsubscribeFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
}
