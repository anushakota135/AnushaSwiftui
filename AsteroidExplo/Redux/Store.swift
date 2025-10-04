//
//  Store.swift
//  AsteroidExplo
//
//  Created by user260596 on 10/2/25.
//

import Foundation
import Combine

@MainActor
final class AppStore: ObservableObject {
    @Published private(set) var state = AppState()
    private let network: NetworkManagerProtocol
    
    init(network: NetworkManagerProtocol = NetworkManager.shared) {
        self.network = network
    }
    
    func dispatch(_ action: AppAction) {
        appReducer(state: &state, action: action)
    }
    
    // MARK: - Async Side Effect
    func fetchAsteroids() async {
        dispatch(.fetchAsteroids)
        do {
            let today = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let startDate = formatter.string(from: today)
            let endDate = formatter.string(from: Calendar.current.date(byAdding: .day, value: 7, to: today)!)
            
            let response = try await network.fetchAsteroids(startDate: startDate, endDate: endDate)
            let allAsteroids = response.nearEarthObjects.values.flatMap { $0 }
                .sorted { $0.name < $1.name }
            
            dispatch(.setAsteroids(allAsteroids))
        } catch {
            dispatch(.setError(error.localizedDescription))
        }
    }
}

