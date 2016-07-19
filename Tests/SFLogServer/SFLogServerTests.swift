import XCTest
@testable import SFLogServer

class SFLogServerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(SFLogServer().text, "Hello, World!")
    }


    static var allTests : [(String, (SFLogServerTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
