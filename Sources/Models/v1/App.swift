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
    var _id: ObjectId
    //app key
    var app_key: String
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
        guard let id = json["_id"].oid,key = json["key"].string, version = json["version"].string, name = json["name"].string,disabled = json["disabled"].bool,deleted = json["delected"].bool, create_time = json["create_time"].date else {
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
