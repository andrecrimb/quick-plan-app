//
//  AuthService.swift
//  quickPlan
//
//  Created by André Rosa on 28/03/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

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

        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]

        Alamofire.request(Constants.Urls.Register, method: .post, parameters: body, encoding: JSONEncoding.default, headers: Constants.Headers.AppJson).responseString { (response) in
            if response.result.error == nil {
                completion(true)
                
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }

        return
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(Constants.Urls.Login, method: .post, parameters: body, encoding: JSONEncoding.default, headers: Constants.Headers.AppJson).responseJSON { (response) in
            print(response)
            if response.result.error == nil{
//                if let json = response.result.value as? Dictionary<String, Any> {
//                    if let email = json["user"] as? String{
//                        self.userEmail = email
//                    }
//                    if let token = json["token"] as? String {
//                        self.authToken = token
//                    }
//                }
                
                // MARK: With SwiftyJSON
                do{
                    guard let data = response.data else {return}
                    let json = try JSON(data: data)
                   
                    self.authToken = json["token"].stringValue
                    self.userEmail = json["user"].stringValue
                    
                    if self.authToken == "" || self.userEmail == "" {
                        
                        completion(false)
                        return
                    }
                    
                    completion(true)
                    self.isLoggedIn = true
                } catch let error{
                    debugPrint("ANDRE: \nERROR: \(error)\n")
                }
               
                
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler){
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
        Alamofire.request(Constants.Urls.UserAdd, method: .post, parameters: body, encoding: JSONEncoding.default, headers: Constants.Headers.Bearer).responseJSON { (response) in
            print(response)
            if response.result.error == nil{
                guard let data = response.data else {return}
                self.setUserInfoData(data: data)
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
            
        }
        
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler){
        Alamofire.request("\(Constants.Urls.UserByEmail)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Constants.Headers.Bearer).responseJSON { (response) in
            if response.result.error == nil{
                guard let data = response.data else {return}
                self.setUserInfoData(data: data)
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func setUserInfoData(data: Data){
        do{
            let json = try JSON(data: data)
            let id = json["_id"].stringValue
            let color = json["avatarColor"].stringValue
            let avatarName = json["avatarName"].stringValue
            let email = json["email"].stringValue
            let name = json["name"].stringValue
            
            UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
        } catch {
            debugPrint("Problem Get data")
        }
    }
    
    func updateUser(name: String, email: String, completion: @escaping CompletionHandler){
        let body: [String: String] = [
            "name": name,
            "email": email,
            "avatarName": UserDataService.instance.avatarName,
            "avatarColor": UserDataService.instance.avatarColor
        ]
        
        Alamofire.request("\(Constants.Urls.UpdateUser)\(UserDataService.instance.id)", method: .put, parameters: body, encoding: JSONEncoding.default, headers: Constants.Headers.Bearer).responseJSON { (response) in
            if response.result.error == nil {
                UserDataService.instance.setUserNameAndEmail(name: name, email: email)
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
}
