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
    case rowser_extension = 10
    case wechat = 20
    case pc = 30
    case ios = 100
    case android = 200
    case windows = 300
}

enum LogLevel: Int {
    case info
    case error
    case debug
    case warn
}

public struct Log: SFModel {
    var _id: ObjectId
    //关联的app
    var app: App
    //来源
    var source: LogSource
    //来源ip
    var source_ip: String
    //上传设备描述
    var device_description: String?
    //设备推送标示
    var device_token:String?
    //日志标题
    var title:String?
    //日志等级
    var level: LogLevel
    //日志内容
    var content: Any
    //创建时间
    var create_time: Date
    //是否删除
    var deleted:Bool
    //log描述
    //var logDescription:LogDescription
    
    public init(json: JSON) throws {
        guard let id = json["_id"].oid, app_info = json["app"].string, source = LogSource(rawValue: json["source"].intValue),source_ip = json["source_ip"].string,level = LogLevel(rawValue: json["level"].intValue), content = json["content"].arrayObject, create_time = json["createTime"].date,deleted = json["deleted"].bool  else {
            throw SFMongoError.invalidData
        }
        self._id = id
        self.app = try App(json:JSON(app_info))
        self.source = source
        self.source_ip = source_ip
        self.device_description = json["device_description"].string
        self.device_token = json["device_token"].string
        self.title = json["title"].string
        self.level = level
        self.content = content
        self.create_time = create_time
        self.deleted = deleted
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



