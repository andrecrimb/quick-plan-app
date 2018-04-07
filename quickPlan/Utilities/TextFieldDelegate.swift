//
//  TextFieldDelegate.swift
//  quickPlan
//
//  Created by André Rosa on 07/04/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
