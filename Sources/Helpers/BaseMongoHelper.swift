//
//  MongoHeplper.swift
//  SFLogServer
//
//  Created by Sean on 16/7/20.
//
//

import Foundation
import MongoDB

public enum MongoError: ErrorProtocol {
    case clientError
    case databaseError
    case collectionError    
}

private let clientUri = "mongodb://localhost"

private let dbName = "Log"

private let collectionName = "col"

public class MongoHelper {
    
    let client: MongoClient
    
    var db: MongoDatabase
    
    public static let instanceHelper = { return MongoHelper()}()
    
    init() {
        client = try! MongoClient(uri: clientUri)
        db = client.getDatabase(name: dbName)
    }
    
    //建立链接
    public func dbCollection() -> MongoCollection? {
        return db.getCollection(name: collectionName)
    }
    
    //关闭数据库
    deinit {
        db.close()
        client.close()
    }
    
}


private protocol MongoProtocol{
    
    var clientUri:String{get}
    
    var dbName:String{get}
    
    var collectionName:String{get}
 
    mutating func dbCollection()->MongoCollection?
    
    mutating func closeDb()throws
}
