//
//  StoreTests.swift
//  AsteroidExplo
//
//  Created by user260596 on 10/5/25.
//
import XCTest
@testable import AsteroidExplo

final class AppStoreTests: XCTestCase {

    @MainActor
    func testDispatch_updatesStateCorrectly() {
        let store = AppStore(network: MockNetworkManager())
        let asteroid = Asteroid.mock()
        
        store.dispatch(.fetchAsteroids)
        XCTAssertTrue(store.state.isLoading)
        
        store.dispatch(.setAsteroids([asteroid]))
        XCTAssertFalse(store.state.isLoading)
        XCTAssertEqual(store.state.asteroids.first?.name, "Mock Asteroid")
        
        store.dispatch(.setError("Oops"))
        XCTAssertFalse(store.state.isLoading)
        XCTAssertEqual(store.state.errorMessage, "Oops")
    }
    
    @MainActor
    func testFetchAsteroids_success() async {
        let mockAsteroid = Asteroid.mock()
        let mockResponse = AsteroidResponse(
            links: ResponseLinks(next: "", previous: "", selfLink: ""),
            elementCount: 1,
            nearEarthObjects: ["2025-10-01": [mockAsteroid]]
        )
        
        let store = AppStore(network: MockNetworkManager(response: mockResponse))
        await store.fetchAsteroids()
        
        XCTAssertFalse(store.state.isLoading)
        XCTAssertEqual(store.state.asteroids.count, 1)
        XCTAssertEqual(store.state.asteroids.first?.name, "Mock Asteroid")
        XCTAssertNil(store.state.errorMessage)
    }
    
    @MainActor
    func testFetchAsteroids_failure() async {
        let mockError = NSError(domain: "TestError", code: 999)
        let store = AppStore(network: MockNetworkManager(error: mockError))
        await store.fetchAsteroids()
        
        XCTAssertFalse(store.state.isLoading)
        XCTAssertEqual(store.state.asteroids.count, 0)
        XCTAssertEqual(store.state.errorMessage, mockError.localizedDescription)
    }
    
  /*  @MainActor
    func testFetchAsteroids_loadingStateDuringFetch() async {
        let mockAsteroid = Asteroid.mock()
        let mockResponse = AsteroidResponse(
            links: ResponseLinks(next: "", previous: "", selfLink: ""),
            elementCount: 1,
            nearEarthObjects: ["2025-10-01": [mockAsteroid]]
        )
        
        let store = AppStore(network: MockNetworkManager(response: mockResponse))
        
        XCTAssertFalse(store.state.isLoading)
        
        // Start fetch in a detached Task
        Task {
            await store.fetchAsteroids()
        }
        
        // Small delay to let MainActor process the fetch dispatch
        try? await Task.sleep(nanoseconds: 50_000_000) // 50ms
        XCTAssertTrue(store.state.isLoading)
        
        // Wait for fetch to finish
        try? await Task.sleep(nanoseconds: 200_000_000) // 200ms
        
        XCTAssertFalse(store.state.isLoading)
        XCTAssertEqual(store.state.asteroids.count, 1)
    }*/
}
