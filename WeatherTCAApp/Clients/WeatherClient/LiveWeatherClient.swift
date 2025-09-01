//
//  LiveWeatherClient.swift
//  WeatherTCAApp
//
//  Created by _ on 2025/09/01.
//

import Foundation

enum LiveWeatherClient {
    static let live = WeatherClient(
        fetch: { city in
            let apiKey = "YOUR_API_KEY" // TODO: .xcconfig or Secrets.swiftに分離推奨
            let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
            guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(encodedCity)&appid=\(apiKey)&units=metric") else {
                throw WeatherClient.Failure.networkError("URLが無効です")
            }

            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw WeatherClient.Failure.networkError("サーバーエラー")
            }

            do {
                let dto = try JSONDecoder().decode(WeatherResponse.self, from: data)
                return dto.toDomain()
            } catch {
                throw WeatherClient.Failure.decodingError
            }
        }
    )
}
