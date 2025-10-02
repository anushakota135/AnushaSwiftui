//
//  State.swift
//  AsteroidExplo
//
//  Created by user260596 on 10/2/25.
//

import Foundation
import Combine

// MARK: - State
struct AppState {
    var asteroids: [Asteroid] = []
    var isLoading: Bool = false
    var errorMessage: String? = nil
}
