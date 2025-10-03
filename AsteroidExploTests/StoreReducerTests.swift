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

final class AppStoreTests: XCTestCase {
    
    func testStoreDispatch_updatesStateCorrectly() {
        let store = AppStore()
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
}

extension Asteroid {
    static func mock(
        id: String = "1",
        name: String = "Mock Asteroid",
        hazardous: Bool = false
    ) -> Asteroid {
        Asteroid(
            links: AsteroidLinks(selfLink: "https://test.com"),
            id: id,
            neoReferenceID: id,
            name: name,
            nasaJplURL: "https://test.com",
            absoluteMagnitude: 22.5,
            estimatedDiameter: EstimatedDiameter(
                kilometers: DiameterRange(estimatedMin: 0.1, estimatedMax: 0.2),
                meters: DiameterRange(estimatedMin: 100, estimatedMax: 200),
                miles: DiameterRange(estimatedMin: 0.06, estimatedMax: 0.12),
                feet: DiameterRange(estimatedMin: 328, estimatedMax: 656)
            ),
            isPotentiallyHazardous: hazardous,
            closeApproachData: [],
            isSentryObject: false
        )
    }
}
