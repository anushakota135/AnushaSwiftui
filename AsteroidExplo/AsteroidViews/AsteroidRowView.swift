//
//  AsteroidRowView.swift
//  AsteroidExplo
//
//  Created by user260596 on 10/2/25.
//
import SwiftUI

struct AsteroidRowView: View {
    let asteroid: Asteroid

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(asteroid.name)
                    .font(.headline)
                    .accessibilityIdentifier("AsteroidName_\(asteroid.id)")

                Text("Magnitude: \(asteroid.absoluteMagnitude, specifier: "%.2f")")
                    .font(.subheadline)
                    .accessibilityIdentifier("AsteroidMagnitude_\(asteroid.id)")
            }
            Spacer()
            Text(asteroid.isPotentiallyHazardous ? "⚠️ Hazardous" : "✅ Safe")
                .foregroundColor(asteroid.isPotentiallyHazardous ? .red : .green)
                .font(.caption)
                .padding(6)
                .background(asteroid.isPotentiallyHazardous ? Color.red.opacity(0.1) : Color.green.opacity(0.1))
                .cornerRadius(6)
                .accessibilityIdentifier("AsteroidSafety_\(asteroid.id)")
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .accessibilityIdentifier("AsteroidRow_\(asteroid.id)")
    }
}

