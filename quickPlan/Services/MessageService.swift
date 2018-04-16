//
//  MessageService.swift
//  quickPlan
//
//  Created by André Rosa on 09/04/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService{
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    
    var selectedChannel: Channel?
    
    func clearChannels(){
        channels.removeAll()
    }
    
    func clearMessages(){
        messages.removeAll()
    }
    
    func findAllChannel(completion: @escaping CompletionHandler){
        Alamofire.request(Constants.Urls.GetChannels, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Constants.Headers.Bearer).responseJSON { (response) in
            
            if response.result.error == nil{
                guard let data = response.data else {return}
                
                // MARK: Using Swift 4 decodable protocol
                // MARK: Using decodable protocal is possible to parse all data with one line of code
//                do {
//                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
//                } catch let error{
//                    debugPrint("Problem Get data \(error)")
//                }
                
                do{
                    if let json = try JSON(data: data).array{
                        for item in json{
                            let name = item["name"].stringValue
                            let channelDescription = item["description"].stringValue
                            let id = item["_id"].stringValue
                            let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                            self.channels.append(channel)
                        }
                        NotificationCenter.default.post(name: Constants.Notifications.ChannelsLoaded, object: nil)
                    }
                } catch {
                    debugPrint("Problem Get data")
                }
                
                completion(true)
                
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
            
        }
    }
    
    func findAllMessagesForChannel(channelId: String, completion: @escaping CompletionHandler){
        Alamofire.request("\(Constants.Urls.GetMessages)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Constants.Headers.Bearer).responseJSON { (response) in
            if response.result.error == nil{
                self.clearMessages()
                
                guard let data = response.data else {return}
                do{
                    if let json = try JSON(data: data).array{
                        for item in json {
                            let messageBody = item["messageBody"].stringValue
                            let channelId = item["channelId"].stringValue
                            let id = item["_id"].stringValue
                            let userName = item["userName"].stringValue
                            let userAvatar = item["userAvatar"].stringValue
                            let userAvatarColor = item["userAvatarColor"].stringValue
                            let timeStamp = item["timeStamp"].stringValue
                            
                            let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                            
                            self.messages.append(message)
                        }
                        print(self.messages)
                        completion(true)
                    }
                
                } catch let error {
                    debugPrint(error)
                }
                
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
}
