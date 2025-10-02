//
//  Actions.swift
//  AsteroidExplo
//
//  Created by user260596 on 10/2/25.
//

import Foundation
import Combine

// MARK: - Actions
enum AppAction {
    case fetchAsteroids
    case setAsteroids([Asteroid])
    case setLoading(Bool)
    case setError(String?)
}
