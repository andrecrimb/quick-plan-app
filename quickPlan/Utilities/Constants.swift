//
//  Constants.swift
//  quickPlan
//
//  Created by André Rosa on 28/03/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

// MARK: TypeAlias

typealias CompletionHandler = (_ Success: Bool) -> ()

struct Constants {
    
    // MARK: URLs
    
    struct Urls {
        static let BaseUrl = "https://quickplan-api.herokuapp.com/v1/"
        static let UrlRegister = "\(Urls.BaseUrl)account/register"
        static let UrlLogin = "\(Urls.BaseUrl)account/login"
    }
    
    // MARK: Segues
    struct Segues {
        static let ToLogin = "toLogin"
        static let ToCreateAccount = "toCreateAccount"
        static let ToChannels = "toChannels"
    }
    
    // MARK: User Defaults
    struct UserDefaults {
        static let TokenKey = "token"
        static let LoggedInKey = "loggedIn"
        static let UserEmail = "userEmail"
    }
    
    // MARK: Headers
    
    struct Headers {
        static let AppJson = [
            "Content-Type": "application/json"
        ]
    }
    
    
}
