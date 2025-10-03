//
//  NetworkManager.swift
//  AsteroidExplo
//
//  Created by user260596 on 10/2/25.
//

import Foundation

// MARK: - Protocol for NetworkManager

protocol NetworkManagerProtocol {
    func fetchAsteroids(startDate: String, endDate: String) async throws -> AsteroidResponse
}

// MARK: - Final NetworkManager
final class NetworkManager: NetworkManagerProtocol {
    static var shared = NetworkManager() // production singleton
    
    private let baseURL = "https://api.nasa.gov/neo/rest/v1"
    private let apiKey = "eh7PH7VWyXtcdIehOdzREHg8nwfuydg5jrapinRA"
    private let jsonDecoder: JSONDecoder
    private let session: URLSession
    
    // MARK: - Init
    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.jsonDecoder = decoder
    }
    
    // MARK: - Fetch
    func fetchAsteroids(startDate: String, endDate: String) async throws -> AsteroidResponse {
        guard var components = URLComponents(string: "\(baseURL)/feed") else {
            throw URLError(.badURL)
        }
        components.queryItems = [
            URLQueryItem(name: "start_date", value: startDate),
            URLQueryItem(name: "end_date", value: endDate),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        guard let url = components.url else { throw URLError(.badURL) }
        
        let (data, response) = try await session.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse,
           !(200..<300).contains(httpResponse.statusCode) {
            throw NSError(domain: "NetworkError", code: httpResponse.statusCode, userInfo: nil)
        }
        
        return try jsonDecoder.decode(AsteroidResponse.self, from: data)
    }
}

