//
//  Store.swift
//  AsteroidExplo
//
//  Created by user260596 on 10/2/25.
//

import Foundation
import Combine

// MARK: - Store
final class AppStore: ObservableObject {
    @Published private(set) var state = AppState()
    
    func dispatch(_ action: AppAction) {
        appReducer(state: &state, action: action)
    }
}
