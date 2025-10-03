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
                        .accessibilityIdentifier("LoadingIndicator")
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(1.5)
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(viewModel.asteroids) { asteroid in
                                NavigationLink(destination: AsteroidDetailView(asteroid: asteroid)) {
                                    AsteroidRowView(asteroid: asteroid)
                                        .padding(.horizontal)
                                        .transition(.move(edge: .bottom).combined(with: .opacity))
                                }
                            }
                        }
                        .padding(.vertical)
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
