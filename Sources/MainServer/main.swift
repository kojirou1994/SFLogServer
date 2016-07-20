import PerfectHTTPServer
import PerfectLib
import PerfectHTTP
import SFMongo
import MongoDB

let server = HTTPServer()

var routes = Routes()

routes.add(method: .get, uri: "/") { (request, response) in
    response.appendBody(string: "Hello World!")
    response.completed()
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
