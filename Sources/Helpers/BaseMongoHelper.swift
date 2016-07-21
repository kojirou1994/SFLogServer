//
//  MongoHeplper.swift
//  SFLogServer
//
//  Created by Sean on 16/7/20.
//
//

import Foundation
import MongoDB
import SFMongo
import Models

public enum MongoError: ErrorProtocol {
    case clientError
    case databaseError
    case collectionError    
}

private let localMongo = "mongodb://localhost"

private let LogDatabaseName = "Log"

public class LogDBManager {
    
    let client: MongoClient
    
    var appCol: MongoCollection
    
    var logCol: MongoCollection
    
    public static let shared = LogDBManager()
    
    public init(mongoUri: String = localMongo) {
        client = try! MongoClient(uri: mongoUri)
        appCol = client.getCollection(databaseName: LogDatabaseName, collectionName: "app")
        logCol = client.getCollection(databaseName: LogDatabaseName, collectionName: "log")
    }
    
}

extension LogDBManager {
    public func validateAppInfo(app: App) -> Bool {
        if let apps = ((appCol.find(query: try! BSON(json: "{}"))?.map{return JSON.parse($0.asString)})?.map{return try! App(json: $0)}) {
            if apps.filter({app.app_key == $0.app_key}).count != 0 {
                return true
            }
        }
        return false
    }
    
    public func insert(log: Log) {
//        print(log.bsonString)
        let _ = logCol.insert(document: try! BSON(json: log.bsonString))
    }
    
    public func findLog(logId: String? = nil) -> [Log]? {
        do {
            let logs = try (logCol.find(query: try! BSON(json: "{}"))?.map{return JSON.parse($0.asString)})?.map{return try Log(json: $0)}
            return logs
        }catch {
            return nil
        }
        
    }
}

private protocol MongoProtocol{
    
    var clientUri:String{get}
    
    var dbName:String{get}
    
    var collectionName:String{get}
 
    mutating func dbCollection()->MongoCollection?
    
    mutating func closeDb()throws
}
