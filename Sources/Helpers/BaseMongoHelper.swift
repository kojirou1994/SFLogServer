//
//  MongoHeplper.swift
//  SFLogServer
//
//  Created by Sean on 16/7/20.
//
//

import Foundation
import MongoDB

public enum MongoError:ErrorProtocol{
    case clinetError
    case datebaseError
    case collectionError    
}

private let clientUri = "mongodb://localhost"

private let dbName = "Log"

private let collectionName = "col"

public class MongoHelper {
    
    let client: MongoClient
    
    var db: MongoDatabase
    
    init() {
        client = try! MongoClient(uri: clientUri)
        db = client.getDatabase(name: dbName)
    }
    
    //建立链接
    public func dbCollection() -> MongoCollection? {
        guard let collection = db.getCollection(name: collectionName) else {
            return nil
        }
        
        return collection
    }
    
    //关闭数据库
    public func closeDb() {
        db.close()
        client.close()
    }

    public static let instanceHelper = { return MongoHelper()}()

}


private protocol MongoProtocol{
    
    var clientUri:String{get}
    
    var dbName:String{get}
    
    var collectionName:String{get}
 
    mutating func dbCollection()->MongoCollection?
    
    mutating func closeDb()throws
}
