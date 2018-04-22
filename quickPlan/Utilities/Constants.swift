//
//  Constants.swift
//  quickPlan
//
//  Created by André Rosa on 28/03/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

// MARK: TypeAlias

typealias CompletionHandler = (_ Success: Bool) -> ()
typealias CompletionHandlerDicString = (_ typingUsers: [String: String]) -> Void

struct Constants {
    
    // MARK: Reusable Identifiers
    struct Identifiers{
        static let AvatarCell = "avatarCell"
        static let ChannelCell = "channelCell"
        static let MessageCell = "messageCell"
    }
    
    // MARK: Notifications
    struct Notifications {
        static let UserDataDidChange = Notification.Name("notifuserDataChanged")
        static let ChannelsLoaded = Notification.Name("channelsLoaded")
        static let ChannelSelected = Notification.Name("channelSelected")
    }
    
    // MARK: Sockets Events
    struct SocketsEvents{
        static let NewChannel = "newChannel"
        static let ChannelCreated = "channelCreated"
        static let MessageCreated = "messageCreated"
        static let UserTypingUpdate = "userTypingUpdate"
        static let StopType = "stopType"
        static let StartType = "startType"
    }
    
    // MARK: URLs
    struct Urls {
        static let Base = "https://quickplan-api.herokuapp.com/v1/"
        static let Register = "\(Urls.Base)account/register"
        static let Login = "\(Urls.Base)account/login"
        static let UserAdd = "\(Urls.Base)user/add"
        static let UserByEmail = "\(Urls.Base)user/byEmail/"
        static let GetChannels = "\(Urls.Base)channel/"
        static let GetMessages = "\(Urls.Base)message/byChannel/"
        static let UpdateUser = "\(Urls.Base)user/"
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
        static let Bearer = [
            "Authorization": "Bearer \(AuthService.instance.authToken)",
            "Content-Type": "application/json"
        ]
    }
    
    
}
