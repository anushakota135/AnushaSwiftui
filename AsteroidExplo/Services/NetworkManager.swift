//
//  NetworkManager.swift
//  AsteroidExplo
//
//  Created by user260596 on 10/2/25.
//

import Foundation

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = "https://api.nasa.gov/neo/rest/v1"
    private let apiKey = "DEMO_KEY" // replace with your NASA key
    
    func fetchAsteroids(startDate: String, endDate: String) async throws -> AsteroidResponse {
        guard let url = URL(string: "\(baseURL)/feed?start_date=\(startDate)&end_date=\(endDate)&api_key=\(apiKey)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(AsteroidResponse.self, from: data)
    }
}
