//
//  MongoHelper.swift
//  SFLogServer
//
//  Created by Sean on 16/7/20.
//
//

import Foundation
import MongoDB

extension MongoHelper{
    
    public func insertLog(logInfo:Log)throws {
        guard let collectiont = dbCollection() else {
            throw MongoError.collectionError
        }
        _ = collectiont.insert(document: try BSON(json:logInfo.bsonString))
        defer {
            collectiont.close()
        }
    }
}
