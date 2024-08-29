//
//  ContentView.swift
//  BasicWeatherApp
//
//  Created by Dalton Alexandre on 8/28/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()
    @AppStorage("City") var searchedCity: String = ""
    @State private var isLoading = true
    
    var body: some View {
        VStack {
            SearchScreen(weatherModel: $viewModel.weather, isLoading: $isLoading)
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: .didUpdateLocation, object: nil, queue: .main) { notification in
                if let userInfo = notification.userInfo,
                   let lat = userInfo["lat"] as? Double,
                   let lon = userInfo["lon"] as? Double {
                    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=3f5be26cb241cb755e1a15dee4272002")!
                    viewModel.fetchWeather(url: url)
                }
            }
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self, name: .didUpdateLocation, object: nil)
        }
    }
}


#Preview {
    ContentView()
}
