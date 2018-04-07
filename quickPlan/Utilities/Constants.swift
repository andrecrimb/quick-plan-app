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
    
    // MARK: Reusable Identifiers
    struct Identifiers{
        static let AvatarCell = "avatarCell"
    }
    
    // MARK: Notifications
    struct Notifications {
        static let NotifUserDataDidChange = Notification.Name("notifuserDataChanged")
    }
    
    
    // MARK: URLs
    struct Urls {
        static let Base = "https://quickplan-api.herokuapp.com/v1/"
        static let Register = "\(Urls.Base)account/register"
        static let Login = "\(Urls.Base)account/login"
        static let UserAdd = "\(Urls.Base)user/add"
    }
    
    // MARK: Segues
    struct Segues {
        static let ToLogin = "toLogin"
        static let ToCreateAccount = "toCreateAccount"
        static let ToChannels = "toChannels"
        static let Unwind = "unwindToLogin"
        static let toAvatarPicker = "toAvatarPicker"
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
