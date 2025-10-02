//
//  AsteroidDetailView.swift
//  AsteroidExplo
//
//  Created by user260596 on 10/2/25.
//

import SwiftUI

struct AsteroidListView: View {
    @StateObject private var viewModel = AsteroidViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading Asteroids…")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                } else {
                    List(viewModel.asteroids) { asteroid in
                        NavigationLink(destination: AsteroidDetailView(asteroid: asteroid)) {
                            VStack(alignment: .leading) {
                                Text(asteroid.name)
                                    .font(.headline)
                                Text("Magnitude: \(asteroid.absoluteMagnitude, specifier: "%.2f")")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Asteroids")
        }
        .task {
            await viewModel.loadAsteroids()
        }
    }
}


#Preview {
    AsteroidListView()
}
