//
//  SocketService.swift
//  quickPlan
//
//  Created by André Rosa on 12/04/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    
    let manager = SocketManager(socketURL: URL(string: Constants.Urls.Base)!)
    lazy var socket:SocketIOClient = manager.defaultSocket
    
    // MARK: Open a connection with the api
    func establishConnection(){
        socket.connect()
    }
    
    // MARK: Close the connection with the api
    func closeConnection(){
        socket.disconnect()
    }
    
    // MARK: Emit an event to api
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler){
        socket.emit(Constants.SocketsEvents.NewChannel, channelName, channelDescription)
        completion(true)
    }
    
    // MARK: Listen to api events, of creating a new channel
    func getChannel(completion: @escaping CompletionHandler){
        socket.on(Constants.SocketsEvents.ChannelCreated) { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDesc = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler){
        let user = UserDataService.instance
        
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
        
    }
    
}
