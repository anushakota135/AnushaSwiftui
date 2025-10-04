//
//  StoreReducerTests.swift
//  AsteroidExplo
//
//  Created by user260596 on 10/3/25.
//
import XCTest
@testable import AsteroidExplo

final class AppReducerTests: XCTestCase {
    
    func testFetchAsteroids_setsLoadingTrue() {
        var state = AppState()
        appReducer(state: &state, action: .fetchAsteroids)
        XCTAssertTrue(state.isLoading)
        XCTAssertNil(state.errorMessage)
    }
    
    func testSetAsteroids_updatesState() {
        var state = AppState(isLoading: true)
        let asteroid = Asteroid.mock()
        appReducer(state: &state, action: .setAsteroids([asteroid]))
        
        XCTAssertFalse(state.isLoading)
        XCTAssertEqual(state.asteroids.count, 1)
        XCTAssertEqual(state.asteroids.first?.name, "Mock Asteroid")
    }
    
    func testSetLoading_updatesLoadingFlag() {
        var state = AppState(isLoading: false)
        appReducer(state: &state, action: .setLoading(true))
        XCTAssertTrue(state.isLoading)
    }
    
    func testSetError_updatesErrorAndStopsLoading() {
        var state = AppState(isLoading: true)
        appReducer(state: &state, action: .setError("Error occurred"))
        
        XCTAssertFalse(state.isLoading)
        XCTAssertEqual(state.errorMessage, "Error occurred")
    }
}
