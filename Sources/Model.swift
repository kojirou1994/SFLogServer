//
//  Model.swift
//  SFLogServer
//
//  Created by Kojirou on 16/7/19.
//
//

import Foundation
import SFMongo

public struct App: SFModel {
    var _id: ObjectId
    
    var info: String
    
    var key: String
    
    var version: Double
    
    var state: AppState
    
    var name: String
    
}

enum AppState: Int {
    case closed = 0
    case open = 1
}
enum LogSource: Int {
    case web = 0
    case iOS = 1
    case android = 2
    case other = 3
}

enum LogLevel {
    case info
    case error
    case debug
    case warn
}

public struct Log: SFModel {
    var _id: ObjectId
    
    var appId: String
    
    var state
    
    var source: LogSource
    
    var userAgent: String
    
    var device: String
    
    var sourceIP: String
    
    var sourceUserIP: String
    
    var sourceUsername: String
    
    var level: LogLevel
    
    var content: String
    
    var createTime: Date
    
    
}

public struct LogDescription: SFModel {
    var userId: String
    
    var description: String
    
    var createTime: Date
}

enum UserState {
    case closed
    case open
}

enum UserPosition {
    
}

public struct UserInfo: SFModel {
    var _id: ObjectId
    
    var state: UserState
    
    var username: String
    
    var realUsername: String
    
    var password: String
    
    var phone: String
    
    var position: UserPosition
    
    var createTime: Date
}
