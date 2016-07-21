//
//  Log.swift
//  SFLogServer
//
//  Created by Sean on 16/7/20.
//
//

import Foundation
import SFMongo
import PerfectHTTP

public enum LogSource: Int, BSONStringConvertible, JSONStringConvertible {
    case web = 0
    case rowser_extension = 10
    case wechat = 20
    case pc = 30
    case ios = 100
    case android = 200
    case windows = 300
    
    public var jsonString: String {
        return self.rawValue.description
    }
    
    public var bsonString: String {
        return self.rawValue.description
    }
}

public enum LogLevel: Int, BSONStringConvertible, JSONStringConvertible {
    case info = 0
    case error = 1
    case debug = 2
    case warn = 3
    
    public var jsonString: String {
        return self.rawValue.description
    }
    
    public var bsonString: String {
        return self.rawValue.description
    }
}

public struct Log: SFModel {
    /// ID
    var _id: ObjectId
    //关联的app
    public var app: App
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
    var content: String
    //创建时间
    var create_time: Date
    //是否删除
    var deleted:Bool
    
    public init(json: JSON) throws {
        print(json["source_ip"].string)
        guard let id = json["_id"].oid, app = try? App(json: json["app"]), source = LogSource(rawValue: json["source"].intValue), source_ip = json["source_ip"].string, level = LogLevel(rawValue: json["level"].intValue), content = json["content"].string, create_time = json["createTime"].date, deleted = json["deleted"].bool else {
            print("not a log")
            throw SFMongoError.invalidData
        }
        self._id = id
        self.app = app
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
    
    public init?(request: HTTPRequest) {
        let json = JSON.parse(request.postBodyString ?? "")
        guard let app = try? App(json: json), source = LogSource(rawValue: json["source"].intValue), level = LogLevel(rawValue: json["level"].intValue), content = json["content"].string else {
            return nil
        }
        self._id = ObjectId.generate()
        self.app = app
        self.source = source
        self.source_ip = request.remoteAddress.host
        self.device_description = json["device_description"].string
        self.device_token = json["device_token"].string
        self.title = json["title"].string
        self.level = level
        self.content = content
        self.create_time = Date()
        self.deleted = false
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



