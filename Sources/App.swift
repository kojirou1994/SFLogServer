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
    
    var info: String
    
    var key: String
    
    var version: String
    
    var state: AppState
    
    var name: String
    
    public init(json: JSON) throws {
        guard let id = json["_id"].oid, info = json["info"].string, key = json["key"].string, version = json["version"].string, state = AppState(rawValue: json["state"].intValue), name = json["name"].string  else {
            throw SFMongoError.invalidData
        }
        
        self._id = id
        self.info = info
        self.key = key
        self.version = version
        self.state = state
        self.name = name
        
    }
    
}

enum AppState: Int {
    case closed = 0
    case open = 1
}
