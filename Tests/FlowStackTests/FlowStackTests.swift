import XCTest
@testable import FlowStack

final class FlowStackTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(FlowStack().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
