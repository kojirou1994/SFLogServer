import PerfectHTTPServer
import PerfectLib
import PerfectHTTP
import SFMongo
import MongoDB
import Models


let server = HTTPServer()

var routes = Routes()

routes.add(method: .get, uri: "/") { (request, response) in
    response.appendBody(string: "Hello World!")
    response.completed()
}

routes.add(method: .post, uri: "/login") { (req, res) in
    guard let appId = req.param(name: "appId"), appKey = req.param(name: "appKey") else {
        res.status = .badRequest
        res.completed()
        return
    }
    print(appId)
    print(appKey)
    res.completed()
}

routes.add(method: .get, uri: "/log/{id}") { (request, response) in
    if let logId = request.urlVariables["id"] {
        print("Log ID: \(logId)")
    }else {
        print("No Log ID")
    }
    response.setHeader(HTTPResponseHeader.Name.contentType, value: "application/json")
    response.setBody(string: "{\"data\": 123}")
    response.completed()
}

routes.add(method: .post, uri: "/log") { request, response in
    guard let newLog = Log(request: request) else {
        response.status = .badRequest
        response.completed()
        return
    }
    dump(newLog)
    response.completed()
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
