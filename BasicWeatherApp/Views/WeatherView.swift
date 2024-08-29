//
//  WeatherView.swift
//  BasicWeatherApp
//
//  Created by Dalton Alexandre on 8/29/24.
//

import SwiftUI

struct WeatherView: View {
    let weatherModel: WeatherModel
    
    var humidity: Double {
        let rawHumidity = weatherModel.main.humidity
        let roundedHumidity = round(rawHumidity * 100) / 100
        return roundedHumidity
    }
    
    var temperature: Double {
        let rawTemp = weatherModel.main.temp
        let roundedTemp = round(rawTemp * 100) / 100
        return roundedTemp
    }
    
    var wind: Double {
        let rawWind = weatherModel.wind.speed
        let roundedWind = round(rawWind * 100) / 100
        return roundedWind
    }
    
    var body: some View {
        VStack {
            Text("Current \(weatherModel.name) Weather").font(.title)
            Text("City: \(weatherModel.name)")
            Text("Weather: \(weatherModel.weather.first?.main ?? "")")
            Text("Temperature: \(temperature)°K")
            Text("Humidity: \(humidity)%")
            Text("Wind Speed: \(wind)m/s")
        }
    }
}
