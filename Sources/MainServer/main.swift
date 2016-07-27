import PerfectHTTPServer
import PerfectLib
import PerfectHTTP
import SFMongo
import MongoDB
import Models
import Helpers

let server = HTTPServer()

var routes = Routes()

routes.add(method: .get, uri: "/") { (request, response) in
    response.appendBody(string: "Not Available")
    response.completed()
}

routes.add(method: .get, uri: "/log") { (request, response) in
    response.setHeader(HTTPResponseHeader.Name.contentType, value: "application/json")
    response.setBody(string: LogDBManager.shared.findLog(request: request)?.jsonString ?? "")
    response.completed()
}

routes.add(method: .get, uri: "/log/{id}") { (request, response) in
    if let logId = request.urlVariables["id"] {
        var logs = LogDBManager.shared.findLog(byLogId: logId)
        response.setHeader(HTTPResponseHeader.Name.contentType, value: "application/json")
        response.setBody(string: logs?.jsonString ?? "")
        logs = nil
    }else {
        response.status = .notFound
    }
    
    response.completed()
}

routes.add(method: .post, uri: "/log") { request, response in
    guard let newLog = Log(request: request) else {
        print("not a log")
        response.status = .badRequest
        response.completed()
        return
    }
    if LogDBManager.shared.validateAppInfo(app: newLog.app) {
        LogDBManager.shared.insert(log: newLog)
        response.status = .created
        response.completed()
    }else {
        print("app key wrong")
        response.status = .forbidden
        response.completed()
    }
}

server.addRoutes(routes)

server.serverPort = 8181

server.documentRoot = "./webroot"

do {
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}


func test() {

}
