//
//  APIServiceProtocol.swift
//  BasicWeatherApp
//
//  Created by Dalton Alexandre on 8/28/24.
//

import Foundation

protocol APIServiceProtocol {
    func fetchWeather(
        url: URL?,
        completion: @escaping(Result<WeatherModel, WeatherError>) -> Void)
}
