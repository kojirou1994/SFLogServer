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

public class MongoHelper:MongoProtocol{
    private var clientUri: String = "mongodb://localhost"
    private var dbName: String = "test"
    private var collectionName: String = "testcollection"
    
    let client:MongoClient?
    var db:MongoDatabase?
    
    private init() {
         client = try! MongoClient(uri: clientUri)
         db = client?.getDatabase(name: dbName)
    }
    
    //建立链接
    public func dbCollection() -> MongoCollection? {
        if db == nil {
            return nil
        }
        guard let collection = db?.getCollection(name: collectionName) else {
            return nil
        }
        
        return collection
    }
    
    //关闭数据库
    public func closeDb()throws {
        if db == nil {
            throw MongoError.datebaseError
        }
        if client == nil {
            throw MongoError.clinetError
        }
        
        db?.close()
        client?.close()
    }

    private static let instanceHelper: MongoHelper = {
        let instance = MongoHelper()
        return instance
    }()
    
    class func instance() -> MongoHelper {
        return instanceHelper
    }
    
//    public class var instance:MongoHelper{
//        struct Static {
//            static let instance = MongoHelper()
//        }
//        return Static.instance
//    }
}


private protocol MongoProtocol{
    
    var clientUri:String{get}
    
    var dbName:String{get}
    
    var collectionName:String{get}
 
    mutating func dbCollection()->MongoCollection?
    
    mutating func closeDb()throws
}
