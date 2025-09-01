//
//  WeatherView.swift
//  WeatherTCAApp
//
//  Created by _ on 2025/09/01.
//

import SwiftUI
import ComposableArchitecture

struct WeatherView: View {
    let store: StoreOf<WeatherReducer>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                VStack(spacing: 20) {
                    // TextField（都市名入力）
                    TextField("都市名を入力", text: viewStore.binding(
                        get: \.cityName,
                        send: WeatherReducer.Action.cityNameChanged
                    ))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                    // 天気取得ボタン
                    Button("天気を取得") {
                        viewStore.send(.fetchWeatherButtonTapped)
                    }
                    .buttonStyle(.borderedProminent)

                    // ステータス表示
                    if viewStore.isLoading {
                        ProgressView()
                    } else if let weather = viewStore.weather {
                        WeatherCardView(weather: weather)
                    } else if let error = viewStore.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                    }

                    Spacer()
                }
                .navigationTitle("天気アプリ")
            }
        }
    }
}

#Preview {
    withDependencies {
        $0.context = .preview // Preview用のコンテキストを設定
    } operation: {
        WeatherView(
            store: Store(
                initialState: WeatherReducer.State(),
                reducer: {
                    WeatherReducer()
                }
            )
        )
    }
}
