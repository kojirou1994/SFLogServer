//
//  MongoHelper.swift
//  SFLogServer
//
//  Created by Sean on 16/7/20.
//
//

import Foundation
import MongoDB
import SFMongo

extension MongoHelper{
    
    public func insert(bson: BSONStringConvertible)throws {
        guard let collectiont = dbCollection() else {
            throw MongoError.collectionError
        }
        _ = collectiont.insert(document: try BSON(json:bson.bsonString))
        defer {
            collectiont.close()
        }
    }
}
