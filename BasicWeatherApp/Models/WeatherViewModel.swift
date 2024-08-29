//
//  WeatherViewModel.swift
//  BasicWeatherApp
//
//  Created by Dalton Alexandre on 8/29/24.
//

import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherModel?
    @Published var errorMessage: String?
    
    private let service = APIService()
    
    func fetchWeather(url: URL) {
        service.fetchWeather(url: url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherModel):
                    self?.weather = weatherModel
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
