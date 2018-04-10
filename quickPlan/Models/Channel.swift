//
//  Channel.swift
//  quickPlan
//
//  Created by André Rosa on 27/03/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import Foundation

// MARK: Using Swift 4 decodable protocol
// MARK: To make work the model has to have all json att with the same name
//struct Channel: Decodable {
//    public private(set) var _id: String!
//    public private(set) var name: String!
//    public private(set) var description: String!
//    public private(set) var __v: Int?
//}


struct Channel {
    public private(set) var channelTitle: String!
    public private(set) var channelDescription: String!
    public private(set) var id: String!
}
