//
//  WeatherError.swift
//  BasicWeatherApp
//
//  Created by Dalton Alexandre on 8/28/24.
//

import Foundation

enum WeatherError: Error, CustomStringConvertible {
    case invalidURL
    case invalidResponse(statusCode: Int)
    case url(URLError)
    case parsing(DecodingError?)
    case invalidData
    case location(Error)
    case unknown
    
    var localizedDescription: String {
        switch self {
            case .invalidURL, .parsing, .invalidData, .unknown:
                return "Sorry, something went wrong."
            case .invalidResponse(_):
                return "Sorry, the connection to our server failed."
            case .url(let error):
                return error.localizedDescription
            case .location(let error):
                return error.localizedDescription
        }
    }
    
    public var description: String {
        switch self {
            case .unknown: return "unknown error"
            case .invalidURL: return "invalid URL"
            case .invalidData: return "invalid Data"
            case .location(let error): return "location error: \(error.localizedDescription)"
            case .url(let error): return error.localizedDescription
            case .parsing(let error): return "parsing error \(error?.localizedDescription ?? "")"
            case .invalidResponse(statusCode: let statusCode): return "bad response with status code \(statusCode)"
        }
    }
}
