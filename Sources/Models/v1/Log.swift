//
//  Log.swift
//  SFLogServer
//
//  Created by Sean on 16/7/20.
//
//

import Foundation
import SFMongo


enum LogSource: Int {
    case web = 0
    case iOS = 1
    case android = 2
    case other = 3
}

enum LogLevel: Int {
    case info
    case error
    case debug
    case warn
}

public struct Log: SFModel {
    var _id: ObjectId
    
    var appId: String
    
    var state: String
    
    var source: LogSource
    
    var userAgent: String
    
    var device: String
    
    var sourceIP: String
    
    var sourceUserId: String
    
    var sourceUsername: String
    
    var level: LogLevel
    
    var content: String
    
    var createTime: Date
    
    //var logDescription:LogDescription
    
    public init(json: JSON) throws {
        guard let id = json["_id"].oid, appId = json["appId"].string, state = json["state"].string, source = LogSource(rawValue: json["source"].intValue), userAgent = json["userAgent"].string, device = json["device"].string, sourceIP = json["sourceIP"].string, sourceUserId = json["sourceUserId"].string, sourceUsername = json["sourceUsername"].string, level = LogLevel(rawValue: json["level"].intValue), content = json["content"].string, createTime = json["createTime"].date  else {
            throw SFMongoError.invalidData
        }
        self._id = id
        self.appId = appId
        self.state = state
        self.source = source
        self.userAgent = userAgent
        self.device = device
        self.sourceIP = sourceIP
        self.sourceUserId = sourceUserId
        self.sourceUsername = sourceUsername
        self.level = level
        self.content = content
        self.createTime = createTime
    }
}



public struct LogDescription: SFModel {
    var userId: String
    
    var description: String
    
    var createTime: Date
    
    public init(json: JSON) throws {
        guard let userId = json["userId"].string, description = json["description"].string, createTime = json["createTime"].date else { throw SFMongoError.invalidData }
        self.userId = userId
        self.description = description
        self.createTime = createTime
    }
}



