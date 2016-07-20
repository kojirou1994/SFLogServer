//
//  User.swift
//  SFLogServer
//
//  Created by Sean on 16/7/20.
//
//

import Foundation
import SFMongo

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
        guard let id = json["_id"].oid, state = UserState(rawValue: json["state"].intValue), username = json["username"].string, realname = json["realname"].string, password =  json["password"].string, phone = json["phone"].string, position =  UserPosition(rawValue: json["position"].intValue), createTime = json["createTime"].date else {
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
