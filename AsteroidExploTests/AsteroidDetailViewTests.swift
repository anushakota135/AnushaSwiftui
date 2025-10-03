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

    func testAsteroidDetailViewRenders() {
        let mockAsteroid = Asteroid(
            links: AsteroidLinks(selfLink: "link"),
            id: "1",
            neoReferenceID: "1",
            name: "Test Asteroid",
            nasaJplURL: "url",
            absoluteMagnitude: 22.5,
            estimatedDiameter: EstimatedDiameter(
                kilometers: DiameterRange(estimatedMin: 0.1, estimatedMax: 0.2),
                meters: DiameterRange(estimatedMin: 100, estimatedMax: 200),
                miles: DiameterRange(estimatedMin: 0.06, estimatedMax: 0.12),
                feet: DiameterRange(estimatedMin: 328, estimatedMax: 656)
            ),
            isPotentiallyHazardous: true,
            closeApproachData: [],
            isSentryObject: false
        )
        
        let view = AsteroidDetailView(asteroid: mockAsteroid)
        let controller = UIHostingController(rootView: view)
        
        XCTAssertNotNil(controller.view) // ensures view hierarchy loads
    }

    final class AsteroidDetailViewTests: XCTestCase {

        func testDetailViewRendersHazardous() {
            let view = AsteroidDetailView(asteroid: hazardousAsteroid)
            let controller = UIHostingController(rootView: view)
            
            // Trigger view loading
            controller.loadViewIfNeeded()
            
            // Smoke test: view exists
            XCTAssertNotNil(controller.view)
        }
        
        func testDetailViewRendersSafe() {
            let view = AsteroidDetailView(asteroid: safeAsteroid)
            let controller = UIHostingController(rootView: view)
            controller.loadViewIfNeeded()
            XCTAssertNotNil(controller.view)
        }
    }
  
    static let hazardousAsteroid = Asteroid(
        links: AsteroidLinks(selfLink: "link"),
        id: "1",
        neoReferenceID: "1",
        name: "Hazardous Asteroid",
        nasaJplURL: "url",
        absoluteMagnitude: 25.0,
        estimatedDiameter: EstimatedDiameter(
            kilometers: DiameterRange(estimatedMin: 0.1, estimatedMax: 0.2),
            meters: DiameterRange(estimatedMin: 100, estimatedMax: 200),
            miles: DiameterRange(estimatedMin: 0.06, estimatedMax: 0.12),
            feet: DiameterRange(estimatedMin: 328, estimatedMax: 656)
        ),
        isPotentiallyHazardous: true,
        closeApproachData: [],
        isSentryObject: false
    )

    static let safeAsteroid = Asteroid(
        links: AsteroidLinks(selfLink: "link"),
        id: "2",
        neoReferenceID: "2",
        name: "Safe Asteroid",
        nasaJplURL: "url",
        absoluteMagnitude: 20.0,
        estimatedDiameter: EstimatedDiameter(
            kilometers: DiameterRange(estimatedMin: 0.05, estimatedMax: 0.1),
            meters: DiameterRange(estimatedMin: 50, estimatedMax: 100),
            miles: DiameterRange(estimatedMin: 0.03, estimatedMax: 0.06),
            feet: DiameterRange(estimatedMin: 164, estimatedMax: 328)
        ),
        isPotentiallyHazardous: false,
        closeApproachData: [],
        isSentryObject: false
    )


}
