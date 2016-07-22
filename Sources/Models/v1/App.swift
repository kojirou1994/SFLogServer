//
//  App.swift
//  SFLogServer
//
//  Created by Sean on 16/7/20.
//
//

import Foundation
import SFMongo

public struct App: SFModel {
    public var _id: ObjectId
    //app key
    public var app_key: String
    //app 名称
    var name: String
    //app 介绍网址
    var description_url:String?
    //创建时间
    var create_time:Date
    //更新时间
    var update_time:Date?
    //是否冻结
    var disabled:Bool
    //是否删除
    var deleted:Bool
    //版本
    var version: String

    public init(json: JSON) throws {
        guard let id = json["_id"].oid, key = json["app_key"].string,
            version = json["version"].string, name = json["name"].string,
            disabled = json["disabled"].bool, deleted = json["deleted"].bool,
            create_time = json["create_time"].date else {
            throw SFMongoError.invalidData
        }
        self._id = id
        self.app_key = key
        self.name = name
        self.description_url = json["description_url"].string
        self.create_time = create_time
        self.update_time = json["update_time"].date
        self.disabled = disabled
        self.deleted = deleted
        self.version = version
    }
}

extension App {
    public init?(requestJSON: JSON) {
        guard let id = ObjectId(oid: requestJSON["_id"].stringValue), key = requestJSON["app_key"].string,
            version = requestJSON["version"].string, name = requestJSON["name"].string,
            disabled = requestJSON["disabled"].bool, deleted = requestJSON["deleted"].bool,
            create_time = requestJSON["create_time"].int else {
                print("not an app")
                return nil
        }
        self._id = id
        self.app_key = key
        self.name = name
        self.description_url = requestJSON["description_url"].string
        self.create_time = Date(timeIntervalSince1970: Double(create_time))
        self.update_time = requestJSON["update_time"].date
        self.disabled = disabled
        self.deleted = deleted
        self.version = version
    }
}
