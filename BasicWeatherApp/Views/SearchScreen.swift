//
//  SearchScreen.swift
//  BasicWeatherApp
//
//  Created by Dalton Alexandre on 8/29/24.
//

import SwiftUI

struct SearchScreen: View {
    @Binding var weatherModel: WeatherModel?
    @Binding var isLoading: Bool
    @State private var error: WeatherError?
    @State private var searchedCity: String
    
    init(weatherModel: Binding<WeatherModel?>, isLoading: Binding<Bool>, searchedCity: String = "") {
        _weatherModel = weatherModel
        _isLoading = isLoading
        self._searchedCity = State(initialValue: UserDefaults.standard.string(forKey: "lastSearchedCity") ?? searchedCity)
    }
    
    var body: some View {
        VStack {
            Text("Basic Weather")
                .font(.title)
            TextField("Enter city", text: $searchedCity)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Search") {
                self.isLoading = true
                UserDefaults.standard.set(self.searchedCity, forKey: "lastSearchedCity")
                guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(searchedCity)&appid=3f5be26cb241cb755e1a15dee4272002") else {
                    self.error = .invalidURL
                    self.isLoading = false
                    return
                }
                fetchWeather(url: url)
            }
            .padding()
            
            if let weatherModel = weatherModel {
                WeatherView(weatherModel: weatherModel)
            } else if let error = error {
                Text("Error: \(error.localizedDescription)")
            } else if isLoading {
                ProgressView()
            }
        }
    }
    
    func fetchWeather(url: URL) {
        let service = APIService()
        service.fetchWeather(url: url) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let weatherModel):
                    self.weatherModel = weatherModel
                    self.error = nil
                case .failure(let error):
                    self.error = error
                    self.weatherModel = nil
                }
            }
        }
    }
}
