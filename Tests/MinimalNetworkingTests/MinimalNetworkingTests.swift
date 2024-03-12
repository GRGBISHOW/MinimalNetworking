import XCTest
@testable import MinimalNetworking

final class MinimalNetworkingTests: XCTestCase {
    func test_addQueryItems() throws {
        var url = URL(string: "https://www.abc.com")
        url?.addQueryItems(queryParams: ["id": "1"])
        XCTAssertEqual(url?.absoluteString, "https://www.abc.com?id=1")
    }
    
    func test_encode() throws {
        guard let url = URL(string: "https://www.abc.com") else {
            XCTFail("not valid url")
            return
        }
        var request = URLRequest(url: url)
        request.addBody(TestStruct())
        XCTAssertNotNil(request.httpBody)
    }
    
    
}
extension  MinimalNetworkingTests {
    struct TestStruct: Encodable {
        let id = 1
    }
}
