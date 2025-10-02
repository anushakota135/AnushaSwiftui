//
//  Reducer.swift
//  AsteroidExplo
//
//  Created by user260596 on 10/2/25.
//

import Foundation
import Combine

// MARK: - Reducer
func appReducer(state: inout AppState, action: AppAction) {
    switch action {
    case .fetchAsteroids:
        state.isLoading = true
    case .setAsteroids(let list):
        state.asteroids = list
        state.isLoading = false
    case .setLoading(let value):
        state.isLoading = value
    case .setError(let error):
        state.errorMessage = error
        state.isLoading = false
    }
}
