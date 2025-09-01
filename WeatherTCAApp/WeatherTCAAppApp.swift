//
//  WeatherTCAAppApp.swift
//  WeatherTCAApp
//
//  Created by _ on 2025/09/01.
//

import SwiftUI
import ComposableArchitecture

@main
struct WeatherTCAAppApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView(
                store: Store(
                    initialState: WeatherReducer.State(),
                    reducer: { WeatherReducer() }
                )
            )
        }
    }
}
