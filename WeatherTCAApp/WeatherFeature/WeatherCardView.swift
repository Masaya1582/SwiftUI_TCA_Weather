//
//  WeatherCardView.swift
//  WeatherCleanApp
//
//  Created by Cookie-san on 2025/09/01.
//

import SwiftUI

struct WeatherCardView: View {
    let weather: Weather

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: iconName(for: weather.description))
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.white)

            Text(weather.cityName)
                .font(.title)
                .bold()
                .foregroundColor(.white)

            Text("\(Int(weather.temperature))°C")
                .font(.system(size: 60))
                .bold()
                .foregroundColor(.white)

            Text(weather.description.capitalized)
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(backgroundColor(for: weather.description).gradient)
        .cornerRadius(24)
        .shadow(radius: 10)
        .padding(.horizontal)
        .transition(.opacity.combined(with: .scale))
        .animation(.easeInOut, value: weather)
    }

    private func iconName(for description: String) -> String {
        switch description.lowercased() {
        case let d where d.contains("cloud"):
            return "cloud.fill"
        case let d where d.contains("rain"):
            return "cloud.rain.fill"
        case let d where d.contains("sun"), let d where d.contains("clear"):
            return "sun.max.fill"
        case let d where d.contains("snow"):
            return "snow"
        default:
            return "cloud.sun.fill"
        }
    }

    private func backgroundColor(for description: String) -> Color {
        switch description.lowercased() {
        case let d where d.contains("cloud"):
            return Color.gray
        case let d where d.contains("rain"):
            return Color.blue
        case let d where d.contains("sun"), let d where d.contains("clear"):
            return Color.orange
        case let d where d.contains("snow"):
            return Color.cyan
        default:
            return Color.indigo
        }
    }
}
