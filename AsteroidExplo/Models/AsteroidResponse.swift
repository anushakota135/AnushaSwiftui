//
//  AsteroidResponse.swift
//  AsteroidExplo
//
//  Created by user260596 on 10/2/25.
//

import Foundation

// MARK: - AsteroidResponse (Root)
public struct AsteroidResponse: Codable {
    let links: ResponseLinks
    let elementCount: Int
    let nearEarthObjects: [String: [Asteroid]]

    enum CodingKeys: String, CodingKey {
        case links
        case elementCount = "element_count"
        case nearEarthObjects = "near_earth_objects"
    }
}

// MARK: - ResponseLinks (Top-level links)
public struct ResponseLinks: Codable {
    let next: String
    let previous: String
    let selfLink: String

    enum CodingKeys: String, CodingKey {
        case next, previous
        case selfLink = "self"
    }
}

// MARK: - Asteroid
public struct Asteroid: Codable, Identifiable {
    let links: AsteroidLinks
    public let id: String
    let neoReferenceID: String
    let name: String
    let nasaJplURL: String
    let absoluteMagnitude: Double
    let estimatedDiameter: EstimatedDiameter
    let isPotentiallyHazardous: Bool
    let closeApproachData: [CloseApproachDatum]
    let isSentryObject: Bool

    enum CodingKeys: String, CodingKey {
        case links, id
        case neoReferenceID = "neo_reference_id"
        case name
        case nasaJplURL = "nasa_jpl_url"
        case absoluteMagnitude = "absolute_magnitude_h"
        case estimatedDiameter = "estimated_diameter"
        case isPotentiallyHazardous = "is_potentially_hazardous_asteroid"
        case closeApproachData = "close_approach_data"
        case isSentryObject = "is_sentry_object"
    }
}

// MARK: - AsteroidLinks
public struct AsteroidLinks: Codable {
    let selfLink: String

    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
    }
}

// MARK: - EstimatedDiameter
public struct EstimatedDiameter: Codable {
    let kilometers: DiameterRange
    let meters: DiameterRange
    let miles: DiameterRange
    let feet: DiameterRange
}

// MARK: - DiameterRange
public struct DiameterRange: Codable {
    let estimatedMin: Double
    let estimatedMax: Double
    
    enum CodingKeys: String, CodingKey {
        case estimatedMin = "estimated_diameter_min"
        case estimatedMax = "estimated_diameter_max"
    }
}

// MARK: - CloseApproachDatum
public struct CloseApproachDatum: Codable {
    let closeApproachDate: String
    let closeApproachDateFull: String?
    let epochDateCloseApproach: Int
    let relativeVelocity: RelativeVelocity
    let missDistance: MissDistance
    let orbitingBody: String

    enum CodingKeys: String, CodingKey {
        case closeApproachDate = "close_approach_date"
        case closeApproachDateFull = "close_approach_date_full"
        case epochDateCloseApproach = "epoch_date_close_approach"
        case relativeVelocity = "relative_velocity"
        case missDistance = "miss_distance"
        case orbitingBody = "orbiting_body"
    }
}

// MARK: - RelativeVelocity
public struct RelativeVelocity: Codable {
    let kilometersPerSecond: String
    let kilometersPerHour: String
    let milesPerHour: String

    enum CodingKeys: String, CodingKey {
        case kilometersPerSecond = "kilometers_per_second"
        case kilometersPerHour = "kilometers_per_hour"
        case milesPerHour = "miles_per_hour"
    }
}

// MARK: - MissDistance
public struct MissDistance: Codable {
    let astronomical: String
    let lunar: String
    let kilometers: String
    let miles: String
}
