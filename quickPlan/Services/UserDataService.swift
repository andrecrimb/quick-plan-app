//
//  UserDataService.swift
//  quickPlan
//
//  Created by André Rosa on 04/04/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import Foundation

// Class responsable to save userdata

class UserDataService {
    
    static let instance = UserDataService()
    
    // Other classes are allowed to read but not to change its value
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String){
        self.id = id
        self.avatarName = avatarName
        self.avatarColor = color
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName
    }
    
    
}
