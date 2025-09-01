//
//  Weather.swift
//  WeatherCleanApp
//
//  Created by Cookie-san on 2025/09/01.
//

import Foundation

struct Weather: Equatable { // Equatable にしておくと ViewModelのテストとか、比較処理にも便利
    let cityName: String
    let temperature: Double
    let description: String
}
