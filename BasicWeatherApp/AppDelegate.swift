//
//  AppDelegate.swift
//  BasicWeatherApp
//
//  Created by Dalton Alexandre on 8/28/24.
//

import CoreLocation
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var weatherViewModel = WeatherViewModel()
    var completion: ((Result<WeatherModel, WeatherError>) -> Void)?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            // Handle the case where the user denied location access
            let alert = UIAlertController(title: "Location Access Denied", message: "Please enable location services in settings.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController?.present(alert, animated: true, completion: nil)
            }
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            let userInfo: [String: Double] = ["lat": lat, "lon": lon]
            NotificationCenter.default.post(name: .didUpdateLocation, object: nil, userInfo: userInfo)
        }
    }
    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Error getting location: \(error.localizedDescription)")
//        
//        let alert = UIAlertController(title: "Location Error", message: "Unable to get your location. Please check your settings.", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        
//        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//           let window = windowScene.windows.first {
//            window.rootViewController?.present(alert, animated: true, completion: nil)
//        }
//    }
    
    func fetchWeather(url: URL) {
        let service = APIService()
        service.fetchWeather(url: url) { result in
            switch result {
            case .success(let weatherModel):
                // Load the initial weather data here
                print("Initial weather data: \(weatherModel)")
            case .failure(let error):
                print("Error fetching weather: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension Notification.Name {
    static let didUpdateLocation = Notification.Name("didUpdateLocation")
}
