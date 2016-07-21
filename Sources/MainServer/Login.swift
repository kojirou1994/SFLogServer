//
//  Login.swift
//  SFLogServer
//
//  Created by Kojirou on 16/7/20.
//
//

import Foundation
import Helpers
import SFMongo
import MongoDB
import Models

enum LoginError: ErrorProtocol {
    case errorInfo
}

struct Login {
    static func login(appId: String, appKey: String) throws -> String {
        throw LoginError.errorInfo
    }
}

func validateAppInfo(app: App) -> Bool {
    let mongo = try! MongoClient(uri: "mongodb://localhost")
    let col = mongo.getCollection(databaseName: "Log", collectionName: "app")
    if let apps = ((col.find(query: try! BSON(json: "{}"))?.map{return JSON.parse($0.asString)})?.map{return try! App(json: $0)}) {
        if apps.filter({app.app_key == $0.app_key}).count != 0 {
            return true
        }
    }
    return false
}

func insert(log: Log) {
    let mongo = try! MongoClient(uri: "mongodb://localhost")
    let col = mongo.getCollection(databaseName: "Log", collectionName: "log")
    print(log.bsonString)
    let _ = col.insert(document: try! BSON(json: log.bsonString))
}
