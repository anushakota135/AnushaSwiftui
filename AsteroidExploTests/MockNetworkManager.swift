//
//  MockNetworkManager.swift
//  AsteroidExplo
//
//  Created by user260596 on 10/3/25.
//
import Foundation
@testable import AsteroidExplo

final class MockNetworkManager: NetworkManagerProtocol {
    var response: AsteroidResponse?
    var error: Error?
    
    init(response: AsteroidResponse? = nil, error: Error? = nil) {
        self.response = response
        self.error = error
    }
    
    func fetchAsteroids(startDate: String, endDate: String) async throws -> AsteroidResponse {
        if let error = error { throw error }
        guard let response = response else {
            throw NSError(domain: "MockNetworkManager", code: 0)
        }
        return response
    }
}
