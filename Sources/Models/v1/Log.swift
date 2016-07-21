//
//  Log.swift
//  SFLogServer
//
//  Created by Sean on 16/7/20.
//
//

import Foundation
import SFMongo


public enum LogSource: Int {
    case web = 0
    case iOS = 1
    case android = 2
    case other = 3
}

public enum LogLevel: Int {
    case info
    case error
    case debug
    case warn
}

public struct Log: SFModel {
    /// ID
    var _id: ObjectId
    /// APP IP
    var appId: String
    /// 状态
    var state: String
    /// 日志来源
    var source: LogSource
    /// 用户UA
    var userAgent: String
    /// 发送设备
    var device: String
    /// 来源IP
    var sourceIP: String
    /// 来源用户id
    var sourceUserId: String
    /// 来源用户名
    var sourceUsername: String
    /// 日志等级
    var level: LogLevel
    /// 日志内容
    var content: String
    /// 创建时间
    var createTime: Date
    
    
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
    
    public init(appId: String, state: String, source: LogSource, userAgent: String, device: String, sourceIP: String, sourceUserId: String, sourceUsername: String, level: LogLevel, content: String, createTime: Date) {
        self._id = ObjectId.generate()
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



