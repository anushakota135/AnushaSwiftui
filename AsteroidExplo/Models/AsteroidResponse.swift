//
//  AsteroidResponse.swift
//  AsteroidExplo
//
//  Created by user260596 on 10/2/25.
//

import Foundation

// MARK: - Feed Response
struct AsteroidResponse: Codable {
    let nearEarthObjects: [String: [Asteroid]]
    
    enum CodingKeys: String, CodingKey {
        case nearEarthObjects = "near_earth_objects"
    }
}

struct Asteroid: Codable, Identifiable {
    let id: String
    let name: String
    let isPotentiallyHazardous: Bool
    let absoluteMagnitude: Double
    let estimatedDiameter: Diameter
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case isPotentiallyHazardous = "is_potentially_hazardous_asteroid"
        case absoluteMagnitude = "absolute_magnitude_h"
        case estimatedDiameter = "estimated_diameter"
    }
}

struct Diameter: Codable {
    let kilometers: DiameterRange
}

struct DiameterRange: Codable {
    let estimatedMin: Double
    let estimatedMax: Double
    
    enum CodingKeys: String, CodingKey {
        case estimatedMin = "estimated_diameter_min"
        case estimatedMax = "estimated_diameter_max"
    }
}
