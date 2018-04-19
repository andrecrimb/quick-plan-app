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
    
    func getChatMessage(completion: @escaping (_ newMessage: Message) -> Void){
        socket.on(Constants.SocketsEvents.MessageCreated) { (dataArray, ack) in
            guard let msgBody = dataArray[0] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            guard let userName = dataArray[3] as? String else {return}
            guard let userAvatar = dataArray[4] as? String else {return}
            guard let userAvatarColor = dataArray[5] as? String else {return}
            guard let id = dataArray[6] as? String else {return}
            guard let timeStamp = dataArray[7] as? String else {return}
            
            let newMessage = Message(message: msgBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
            
            completion(newMessage)
        }
    }
    
    func getTypingUsers(_ completionHandler: @escaping CompletionHandlerDicString){
        socket.on(Constants.SocketsEvents.UserTypingUpdate) { (dataArray, akc) in
            guard let typingUsers = dataArray[0] as? [String: String] else {return}
            completionHandler(typingUsers)
        }
    }
    
}









