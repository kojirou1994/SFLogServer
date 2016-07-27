//
//  User.swift
//  SFLogServer
//
//  Created by Sean on 16/7/20.
//
//

import Foundation
import SFMongo
import PerfectHTTP

enum UserState: Int {
    case closed = 0
    case open = 1
}

enum UserPosition: Int {
    case boss
}


public struct UserInfo: SFModel {
    var _id: ObjectId
    
    var state: UserState
    
    var username: String
    
    var realname: String
    
    var password: String
    
    var phone: String
    
    var position: UserPosition
    
    var createTime: Date
    
    public init(json: JSON) throws {
        guard let id = json["_id"].oid, let state = UserState(rawValue: json["state"].intValue), let username = json["username"].string, let realname = json["realname"].string, let password =  json["password"].string, let phone = json["phone"].string, let position =  UserPosition(rawValue: json["position"].intValue), let createTime = json["createTime"].date else {
            throw SFMongoError.invalidData
        }
        self._id = id
        self.state = state
        self.username = username
        self.realname = realname
        self.password = password
        self.phone = phone
        self.position = position
        self.createTime = createTime
    }
}
