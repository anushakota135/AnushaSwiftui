//
//  AsteroidDetailViewTests.swift
//  AsteroidExplo
//
//  Created by user260596 on 10/3/25.
//
import XCTest
import SwiftUI
@testable import AsteroidExplo

final class AsteroidDetailViewTests: XCTestCase {

    func testAsteroidDetailViewRendersHazardous() {
        let view = AsteroidDetailView(asteroid: AsteroidDetailViewTests.hazardousAsteroid)
        let controller = UIHostingController(rootView: view)
        controller.loadViewIfNeeded()
        XCTAssertNotNil(controller.view)
    }
    
    func testAsteroidDetailViewRendersSafe() {
        let view = AsteroidDetailView(asteroid: AsteroidDetailViewTests.safeAsteroid)
        let controller = UIHostingController(rootView: view)
        controller.loadViewIfNeeded()
        XCTAssertNotNil(controller.view)
    }

    static let hazardousAsteroid = Asteroid.mock(id: "1", name: "Hazardous Asteroid", hazardous: true)
    static let safeAsteroid = Asteroid.mock(id: "2", name: "Safe Asteroid", hazardous: false)
}
