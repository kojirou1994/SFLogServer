//
//  LogQuery.swift
//  SFLogServer
//
//  Created by Kojirou on 16/7/22.
//
//

import Foundation
import SFMongo
import MongoDB
import PerfectHTTP

public struct LogQuery {
    public private(set) var limit = 20
    var startTime: Int?
    var endTime: Int?
    var source: Int?
    var level = 0
    var deleted: Bool?
    
    public init(_ request: HTTPRequest) {
        if let l = request.param(name: "limit") {
            if let limit = Int(l) {
                self.limit = limit
            }
        }
        if let t = request.param(name: "starttime") {
            if let s = Int(t) {
                self.startTime = s
            }
        }
        if let t = request.param(name: "endtime") {
            if let s = Int(t) {
                self.endTime = s
            }
        }
        if let t = request.param(name: "source") {
            if let s = Int(t) {
                self.source = s
            }
        }
        if let t = request.param(name: "level") {
            if let s = Int(t) {
                self.level = s
            }
        }
        if let t = request.param(name: "deleted") {
            self.deleted = t == "true"
        }
    }
    
    public var query: BSON {
        let q = BSON()

        if startTime != nil {
            _ = q.append(key: "create_time", document: try! BSON(json: "{\"$gt\": {\"$date\": \(startTime!)} }"))
        }
        if endTime != nil {
            _ = q.append(key: "create_time", document: try! BSON(json: "{\"$lt\": {\"$date\": \(endTime!)} }"))
        }
        if source != nil {
            _ = q.append(key: "source", int: source!)
        }
        if deleted != nil {
            _ = q.append(key: "deleted", bool: deleted!)
        }
        _ = q.append(key: "level", document: try! BSON(json: "{\"$lte\": \(level)}"))
        return q
    }
    
}
