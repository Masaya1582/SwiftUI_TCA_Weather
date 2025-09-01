# ☀️ SwiftUI × TCA Weather（日本語版）

このアプリは、**SwiftUI × The Composable Architecture (TCA)** を使って構築したシンプルな天気アプリです。  
最小限の構成で、状態管理・非同期処理・依存注入の流れを学べるように設計されています。  
TCAの最低限の理解にどうぞ。

---

## 📱 主な機能

- 🌍 都市名で天気を検索
- 🌡️ 現在の気温と天気情報を表示
- 🎨 天気に応じてUIの色やアイコンを自動変更
- 🔄 async/await + OpenWeather API 使用
- 🧠 The Composable Architecture（TCA）で状態管理

---

## 🧠 アーキテクチャ構成

```
WeatherTCAApp/
├── WeatherFeature/
│   ├── WeatherView.swift             ← 画面UI
│   ├── WeatherReducer.swift          ← State / Action / Reducer
│   └── WeatherView+Store.swift       ← Store注入用のエントリポイント
│
├── Clients/
│   └── WeatherClient/
│       ├── WeatherClient.swift       ← 抽象依存 (DependencyKey)
│       └── LiveWeatherClient.swift   ← 実際のAPI実装
│
├── Models/
│   └── Weather.swift                 ← アプリ内部モデル
│
├── DTO/
│   └── WeatherResponse.swift         ← APIレスポンス用の構造体
```

> ✅ TCAの依存注入（DependencyKey）を使い、**テスト・プレビュー・本番**で実装を自動で切り替え可能。  
> → 単方向のデータフロー＆モック注入が容易な構造です。

---

## 🔧 使い方

1. このリポジトリをクローン  
2. `LiveWeatherClient.swift` にAPIキーを記入：

   ```swift
   let apiKey = "YOUR_API_KEY"
   ```

3. `WeatherView_PreviewWrapper()` を起動 or アプリ起動！

---

## 🧪 テストしやすい理由

TCAでは依存を `DependencyKey` として定義することで：

- ✅ `liveValue`, `previewValue`, `testValue` を明示的に切り替え可能
- ✅ テスト環境では自動で `testValue` が使われる
- ✅ `withDependencies` を使って一時的に依存差し替えもできる
- ✅ SwiftUI Previews でも `previewValue` が自動で使われる

---

## 🌈 スクリーンショット
<img src="https://github.com/user-attachments/assets/8a61abce-0f88-4410-aaa6-72b9ae39a113" width="300" />

---

## 🤔 なぜ TCA？

- 状態管理・副作用処理・依存注入をすべて型安全に扱える
- 機能を「Feature単位」で分離しやすい
- テスト・Preview・本番を完全に分離できる
- 中〜大規模アプリでも拡張性バツグン

---

## ✅ 拡張機能の案

- [ ] `WeatherReducerTests.swift` にユニットテスト追加
- [ ] プレビュー用の `previewValue` をさらにリッチに
- [ ] ForecastFeature（週間天気）を追加してFeature分割体験

---

## 📄 ライセンス

MIT
