//
//  WeatherDTO.swift
//  WeatherTCAApp
//
//  Created by _ on 2025/09/01.
//

import Foundation

struct WeatherResponse: Decodable {
    let name: String
    let main: Main
    let weather: [WeatherInfo]

    struct Main: Decodable {
        let temp: Double
    }

    struct WeatherInfo: Decodable {
        let description: String
    }

    func toDomain() -> Weather {
        Weather(
            cityName: name,
            temperature: main.temp,
            description: weather.first?.description ?? "no data"
        )
    }
}
