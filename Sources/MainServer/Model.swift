////
////  Model.swift
////  SFLogServer
////
////  Created by Kojirou on 16/7/19.
////
////
//
//import Foundation
//import SFMongo
//
//public struct App: SFModel {
//    var _id: ObjectId
//    
//    var info: String
//    
//    var key: String
//    
//    var version: String
//    
//    var state: AppState
//    
//    var name: String
//    
//    public init(json: JSON) throws {
//        guard let id = json["_id"].oid, info = json["info"].string, key = json["key"].string, version = json["version"].string, state = AppState(rawValue: json["state"].intValue), name = json["name"].string  else {
//            throw SFMongoError.invalidData
//        }
//        
//        self._id = id
//        self.info = info
//        self.key = key
//        self.version = version
//        self.state = state
//        self.name = name
//        
//    }
//    
//}
//
//enum AppState: Int {
//    case closed = 0
//    case open = 1
//}
//enum LogSource: Int {
//    case web = 0
//    case iOS = 1
//    case android = 2
//    case other = 3
//}
//
//enum LogLevel: Int {
//    case info
//    case error
//    case debug
//    case warn
//}
//
//enum LogState {
//    
//}
//
//public struct Log: SFModel {
//    var _id: ObjectId
//    
//    var appId: String
//    
//    var state: String
//    
//    var source: LogSource
//    
//    var userAgent: String
//    
//    var device: String
//    
//    var sourceIP: String
//    
//    var sourceUserId: String
//    
//    var sourceUsername: String
//    
//    var level: LogLevel
//    
//    var content: String
//    
//    var createTime: Date
//    
//    public init(json: JSON) throws {
//        guard let id = json["_id"].oid, appId = json["appId"].string, state = json["state"].string, source = LogSource(rawValue: json["source"].intValue), userAgent = json["userAgent"].string, device = json["device"].string, sourceIP = json["sourceIP"].string, sourceUserId = json["sourceUserId"].string, sourceUsername = json["sourceUsername"].string, level = LogLevel(rawValue: json["level"].intValue), content = json["content"].string, createTime = json["createTime"].date  else {
//            throw SFMongoError.invalidData
//        }
//        self._id = id
//        self.appId = appId
//        self.state = state
//        self.source = source
//        self.userAgent = userAgent
//        self.device = device
//        self.sourceIP = sourceIP
//        self.sourceUserId = sourceUserId
//        self.sourceUsername = sourceUsername
//        self.level = level
//        self.content = content
//        self.createTime = createTime
//    }
//    
//    
//}
//
//public struct LogDescription: SFModel {
//    var userId: String
//    
//    var description: String
//    
//    var createTime: Date
//    
//    public init(json: JSON) throws {
//        guard let userId = json["userId"].string, description = json["description"].string, createTime = json["createTime"].date else { throw SFMongoError.invalidData }
//        self.userId = userId
//        self.description = description
//        self.createTime = createTime
//    }
//}
//
//enum UserState: Int {
//    case closed = 0
//    case open = 1
//}
//
//enum UserPosition: Int {
//    case boss
//}
//
//public struct UserInfo: SFModel {
//    var _id: ObjectId
//    
//    var state: UserState
//    
//    var username: String
//    
//    var realname: String
//    
//    var password: String
//    
//    var phone: String
//    
//    var position: UserPosition
//    
//    var createTime: Date
//    
//    public init(json: JSON) throws {
//        guard let id = json["_id"].oid, state = UserState(rawValue: json["state"].intValue), username = json["username"].string, realname = json["realname"].string, password =  json["password"].string, phone = json["phone"].string, position =  UserPosition(rawValue: json["position"].intValue), createTime = json["createTime"].date else {
//            throw SFMongoError.invalidData
//        }
//        self._id = id
//        self.state = state
//        self.username = username
//        self.realname = realname
//        self.password = password
//        self.phone = phone
//        self.position = position
//        self.createTime = createTime
//    }
//}
