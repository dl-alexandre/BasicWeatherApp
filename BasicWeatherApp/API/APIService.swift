//
//  APIService.swift
//  BasicWeatherApp
//
//  Created by Dalton Alexandre on 8/28/24.
//

import Foundation

class APIService: NSObject {

    var completion: ((Result<WeatherModel, WeatherError>) -> Void)?
    
    override init() {
        super.init()
    }
    
    func fetchWeather(url: URL?, completion: @escaping (Result<WeatherModel, WeatherError>) -> Void) {
        guard let url = url else {
            let error = WeatherError.invalidURL
            completion(Result.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            if let error = error as? URLError {
                completion(Result.failure(WeatherError.url(error)))
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(WeatherError.invalidResponse(statusCode: response.statusCode)))
            }
            
            let decoder = JSONDecoder()
            
            if let data = data {
                print(String(data: data, encoding: .utf8) ?? "Invalid data")
                do {
                    let weather = try decoder.decode(WeatherModel.self, from: data)
                    print(data)
                    completion(Result.success(weather))
                } catch {
                    print(data)
                    completion(Result.failure(WeatherError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
}
