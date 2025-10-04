//
//  AsteroidExploTests.swift
//  AsteroidExploTests
//
//  Created by user260596 on 9/27/25.
//

import XCTest
@testable import AsteroidExplo

final class NetworkManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        MockURLProtocol.requestHandler = nil
    }

    override func tearDown() {
        MockURLProtocol.requestHandler = nil
        super.tearDown()
    }
    
   
    func testFetchAsteroids_HTTPError() async {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: URL(string: "https://api.nasa.gov")!,
                                           statusCode: 429,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, Data())
        }
        
        do {
            _ = try await NetworkManager.shared.fetchAsteroids(startDate: "2025-10-01", endDate: "2025-10-01")
            XCTFail("Expected HTTP error")
        } catch {
            let nsError = error as NSError
                XCTAssertEqual(nsError.domain, NSCocoaErrorDomain)
        }
    }
    
    func testFetchAsteroids_DecodingError() async {
        let invalidJSON = "{ \"invalid\": 123 }".data(using: .utf8)!
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: URL(string: "https://api.nasa.gov")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, invalidJSON)
        }
        
        do {
            _ = try await NetworkManager.shared.fetchAsteroids(startDate: "2025-10-01", endDate: "2025-10-01")
            XCTFail("Expected decoding error")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }
}

