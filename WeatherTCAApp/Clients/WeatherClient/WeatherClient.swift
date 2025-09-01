//
//  WeatherClient.swift
//  WeatherTCAApp
//
//  Created by _ on 2025/09/01.
//

import Foundation
import ComposableArchitecture

// MARK: - WeatherClient Dependency
struct WeatherClient {
    var fetch: (String) async throws -> Weather

    enum Failure: Error, Equatable, LocalizedError {
        case decodingError
        case networkError(String)
        case unknown

        var errorDescription: String? {
            switch self {
            case .decodingError:
                return "データの読み込みに失敗しました。"
            case .networkError(let msg):
                return "通信エラー: \(msg)"
            case .unknown:
                return "不明なエラーが発生しました。"
            }
        }
    }
}

// MARK: - DependencyKey登録
extension WeatherClient: DependencyKey {
    static let liveValue: WeatherClient = LiveWeatherClient.live
    static let testValue: WeatherClient = WeatherClient(
        fetch: { _ in
            return Weather(cityName: "Mock City", temperature: 20.5, description: "clear sky")
        }
    )
    static let previewValue: WeatherClient = WeatherClient(
        fetch: { _ in
            Weather(cityName: "Preview City", temperature: 33.4, description: "☁️ Preview Sky")
        }
    )
}

// MARK: - 依存注入として登録
extension DependencyValues {
    var weatherClient: WeatherClient {
        get { self[WeatherClient.self] }
        set { self[WeatherClient.self] = newValue }
    }
}
