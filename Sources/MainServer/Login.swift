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




