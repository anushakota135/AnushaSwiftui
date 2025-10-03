//
//  AsteroidListView.swift
//  AsteroidExplo
//
//  Created by user260596 on 10/2/25.
//

import SwiftUI

struct AsteroidDetailView: View {
    let asteroid: Asteroid
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(asteroid.name)
                    .font(.largeTitle)
                    .bold()
                
                Text("Absolute Magnitude: \(asteroid.absoluteMagnitude, specifier: "%.2f")")
                    .font(.headline)
                
                Text("Hazardous: \(asteroid.isPotentiallyHazardous ? "Yes 🚨" : "No ✅")")
                    .font(.headline)
                    .foregroundColor(asteroid.isPotentiallyHazardous ? .red : .green)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Estimated Diameter (km)")
                        .font(.title2)
                        .bold()
                    
                    Text("Min: \(asteroid.estimatedDiameter.kilometers.estimatedMin, specifier: "%.2f") km")
                    Text("Max: \(asteroid.estimatedDiameter.kilometers.estimatedMax, specifier: "%.2f") km")
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Details")
    }
}

