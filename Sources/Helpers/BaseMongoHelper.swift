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
import PerfectHTTP

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
            if apps.filter({app.app_key == $0.app_key && app._id == $0._id}).count != 0 {
                return true
            }
        }
        return false
    }
    
    public func insert(log: Log) {
//        print(log.bsonString)
        let _ = logCol.insert(document: try! BSON(json: log.bsonString))
    }
    
    /**
     *  find Log in database
     *
     *  - parameter limit:    Optional. return no more than the supplied number of logs. default is 20.
     *  - parameter logId:    Optional. return the log(s) of specific logid(s). default is nil.
     *  - parameter startTime:    Optional. 微秒
     *
     *  - returns:
     */
    public func findLog(request: HTTPRequest) -> [Log]? {
        let sql = LogQuery(request)
        do {
            let logs = try (logCol.find(query: sql.query, limit: sql.limit)?.map{return JSON.parse($0.asString)})?.map{return try Log(json: $0)}
            return logs
        }catch {
            return nil
        }
    }
    
    public func findLog(byLogId: String) -> Log? {
        let query = BSON()
        _ = query.append(key: "_id", oid: ObjectId.parse(oid: byLogId))
        do {
            let logs = try (logCol.find(query: query)?.map{return JSON.parse($0.asString)})?.map{return try Log(json: $0)}
            return logs?.first
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
