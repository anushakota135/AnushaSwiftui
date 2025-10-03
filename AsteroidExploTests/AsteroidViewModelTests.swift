//
//  AsteroidViewModelTests.swift
//  AsteroidExplo
//
//  Created by user260596 on 10/3/25.
//

import XCTest
@testable import AsteroidExplo

@MainActor
final class AsteroidViewModelTests: XCTestCase {
    
    var viewModel: AsteroidViewModel!
    var mockNetwork: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockNetwork = MockNetworkManager()
        viewModel = AsteroidViewModel(network: mockNetwork)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetwork = nil
        super.tearDown()
    }
    
    func testLoadAsteroids_Success() async {
        let asteroid = Asteroid.mock()
        let response = AsteroidResponse(
            links: ResponseLinks(next: "next", previous: "prev", selfLink: "self"),
            elementCount: 1,
            nearEarthObjects: ["2025-10-01": [asteroid]]
        )
        mockNetwork.response = response
        
        await viewModel.loadAsteroids()
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.asteroids.count, 1)
        XCTAssertEqual(viewModel.asteroids.first?.name, "Mock Asteroid")
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testLoadAsteroids_Failure() async {
        mockNetwork.error = NSError(domain: "TestError", code: 123)
        
        await viewModel.loadAsteroids()
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.asteroids.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, "The operation couldn’t be completed. (TestError error 123.)")
    }
}

