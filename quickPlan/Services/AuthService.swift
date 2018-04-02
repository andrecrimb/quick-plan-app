//
//  AuthService.swift
//  quickPlan
//
//  Created by André Rosa on 28/03/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import Foundation
import Alamofire

// MARK: Service to persist throught the app

class AuthService {
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool{
        get{
            return defaults.bool(forKey: Constants.UserDefaults.LoggedInKey)
        }
        set{
            defaults.set(newValue, forKey: Constants.UserDefaults.LoggedInKey)
        }
    }
    
    var authToken: String{
        get{
            return defaults.value(forKey: Constants.UserDefaults.TokenKey) as! String
        }
        set{
            defaults.set(newValue, forKey: Constants.UserDefaults.TokenKey)
        }
    }

    var userEmail: String{
        get{
            return defaults.value(forKey: Constants.UserDefaults.UserEmail) as! String
        }
        set{
            defaults.set(newValue, forKey: Constants.UserDefaults.UserEmail)
        }
    }
    
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()

        let header = [
            "Content-Type": "application/json; charset=uft-8"
        ]
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]

        Alamofire.request(Constants.Urls.UrlRegister, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            if response.result.error == nil {
                completion(true)
                Struc
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }

        return
    }
    
    
    
    
    
    
    
    
}
