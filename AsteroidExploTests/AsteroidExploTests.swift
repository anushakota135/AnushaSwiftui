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
    
    /*func testFetchAsteroids_Success() async throws {
        // Mock JSON
        let mockJSON = """
        {
          "links": { 
            "next": "next", 
            "previous": "prev", 
            "self": "self" 
          },
          "element_count": 1,
          "near_earth_objects": {
            "2025-10-01": [
              {
                "links": { "self": "link" },
                "id": "1",
                "neo_reference_id": "1",
                "name": "Mock Asteroid",
                "nasa_jpl_url": "url",
                "absolute_magnitude_h": 22.5,
                "estimated_diameter": {
                  "kilometers": { "estimated_diameter_min": 0.1, "estimated_diameter_max": 0.2 },
                  "meters": { "estimated_diameter_min": 100.0, "estimated_diameter_max": 200.0 },
                  "miles": { "estimated_diameter_min": 0.06, "estimated_diameter_max": 0.12 },
                  "feet": { "estimated_diameter_min": 328.0, "estimated_diameter_max": 656.0 }
                },
                "is_potentially_hazardous_asteroid": false,
                "close_approach_data": [
                  {
                    "close_approach_date": "2025-10-01",
                    "close_approach_date_full": "2025-Oct-01 12:34",
                    "epoch_date_close_approach": 1769999999,
                    "relative_velocity": {
                      "kilometers_per_second": "12.34",
                      "kilometers_per_hour": "44424.0",
                      "miles_per_hour": "27600.0"
                    },
                    "miss_distance": {
                      "astronomical": "0.123",
                      "lunar": "47.9",
                      "kilometers": "18400000",
                      "miles": "11400000"
                    },
                    "orbiting_body": "Earth"
                  }
                ],
                "is_sentry_object": false
              }
            ]
          }
        }
        """.data(using: .utf8)!

        
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: URL(string: "https://api.nasa.gov")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, mockJSON)
        }
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        
        let result = try await NetworkManager.shared.fetchAsteroids(startDate: "2025-10-01", endDate: "2025-10-01")
        XCTAssertEqual(result.nearEarthObjects["2025-10-01"]?.first?.name, "Mock Asteroid")
    }*/
    
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

