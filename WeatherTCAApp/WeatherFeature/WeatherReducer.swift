//
//  WeatherReducer.swift
//  WeatherTCAApp
//
//  Created by _ on 2025/09/01.
//

import Foundation
import ComposableArchitecture

struct WeatherReducer: Reducer {
    // MARK: - State（画面の状態）
    struct State: Equatable {
        var cityName: String = ""
        var weather: Weather?
        var isLoading: Bool = false
        var errorMessage: String?
    }

    // MARK: - Action（ユーザー操作・非同期イベント）
    enum Action: Equatable {
        case cityNameChanged(String)
        case fetchWeatherButtonTapped
        case weatherResponse(Result<Weather, WeatherClient.Failure>)
    }

    // MARK: - Dependencies（明示的な依存）
    @Dependency(\.weatherClient) var weatherClient

    // MARK: - Reducer本体
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .cityNameChanged(name):
            state.cityName = name
            return .none

        case .fetchWeatherButtonTapped:
            guard !state.cityName.isEmpty else {
                state.errorMessage = "都市名を入力してください"
                return .none
            }

            state.isLoading = true
            state.errorMessage = nil

            return .run { [city = state.cityName] send in
                do {
                    let result = try await weatherClient.fetch(city)
                    await send(.weatherResponse(.success(result)))
                } catch {
                    await send(.weatherResponse(.failure(error as? WeatherClient.Failure ?? .unknown)))
                }
            }

        case let .weatherResponse(.success(weather)):
            state.weather = weather
            state.isLoading = false
            return .none

        case let .weatherResponse(.failure(error)):
            state.errorMessage = error.localizedDescription
            state.isLoading = false
            return .none
        }
    }
}
