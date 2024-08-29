//
//  WeatherModel.swift
//  BasicWeatherApp
//
//  Created by Dalton Alexandre on 8/29/24.
//

struct WeatherModel: Codable {
    let coord: Coordinate
    let weather: [Weather]
    let base: String
    let main: MainData
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: System
    let timezone: Int?
    let id: Int
    let name: String
    let cod: Int
    
    enum CodingKeys: String, CodingKey {
        case coord = "coord"
        case weather = "weather"
        case base = "base"
        case main = "main"
        case visibility = "visibility"
        case wind = "wind"
        case clouds = "clouds"
        case dt = "dt"
        case sys = "sys"
        case timezone = "timezone"
        case id = "id"
        case name = "name"
        case cod = "cod"
    }
}

struct Coordinate: Codable, Hashable {
    let lat: Double
    let lon: Double
    
    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lon = "lon"
    }
}

struct Weather: Codable, Hashable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct MainData: Codable, Hashable {
    let temp: Double
    let pressure: Double
    let humidity: Double
    let temp_min: Double
    let temp_max: Double
}

struct Wind: Codable, Hashable {
    let speed: Double
    let deg: Double
}

struct Clouds: Codable, Hashable {
    let all: Int
}

struct System: Codable, Hashable {
    let type: Int
    let id: Int
    let message: Double?
    let country: String
    let sunrise: Int
    let sunset: Int
}
