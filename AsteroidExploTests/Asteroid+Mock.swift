//
//  Asteroid+Mock.swift
//  AsteroidExplo
//
//  Created by user260596 on 10/5/25.
//
import Foundation
@testable import AsteroidExplo

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
