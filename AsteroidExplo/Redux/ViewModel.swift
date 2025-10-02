//
//  ViewModel.swift
//  AsteroidExplo
//
//  Created by user260596 on 10/2/25.
//

import Foundation

@MainActor
final class AsteroidViewModel: ObservableObject {
    @Published var asteroids: [Asteroid] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadAsteroids() async {
        isLoading = true
        do {
            let today = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let startDate = formatter.string(from: today)
            let endDate = formatter.string(from: Calendar.current.date(byAdding: .day, value: 7, to: today)!)
            
            let response = try await NetworkManager.shared.fetchAsteroids(startDate: startDate, endDate: endDate)
            
            let allAsteroids = response.nearEarthObjects.values.flatMap { $0 }
            
            DispatchQueue.main.async {
                self.asteroids = allAsteroids.sorted { $0.name < $1.name }
                self.isLoading = false
            }
        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }
}
