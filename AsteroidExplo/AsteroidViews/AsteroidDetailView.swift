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
        VStack(spacing: 20) {
            Text(asteroid.name).font(.largeTitle)
            Text("Hazardous: \(asteroid.isPotentiallyHazardous ? "Yes" : "No")")
            Text("Size: \(asteroid.estimatedDiameter.kilometers.estimatedMin, specifier: "%.2f") - \(asteroid.estimatedDiameter.kilometers.estimatedMax, specifier: "%.2f") km")
        }
        .padding()
    }
}

