//
//  WeatherViewModel.swift
//  Forecast
//
//  Created by Mansa Pratap Singh on 31/05/21.
//

import SwiftUI
import CoreLocation

final class WeatherViewModel: NSObject, ObservableObject {
    
    @Published var showAlert = false
    @Published var isLoading = true
    @Published var appError: AppError? = nil
    
    @Published var cityName = ""
    @Published var currentCityName = ""
    
    @Published var current: WeatherDataModel.Current?
    @Published var daily: [WeatherDataModel.Daily]?
    @Published var hourly: [WeatherDataModel.Hourly]?
    
    let apiService = APIService.shared
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        requestLocation()
    }
    
    func getWeather() {
        isLoading = true
        if let coordinate = locationManager.location?.coordinate {
            performWeatherRequest(with: coordinate)
        }
    }
    
    func fetchWeatherByCityName() {
        if cityName != "" {
            CLGeocoder().geocodeAddressString(cityName) { (placemarks, error) in
                if let coordinate = placemarks?.first?.location?.coordinate {
                    self.performWeatherRequest(with: coordinate)
                    self.currentCityName = self.cityName
                    print(self.currentCityName)
                }
            }
        }
    }
    
    func performWeatherRequest(with coordinate: CLLocationCoordinate2D) {
        API.checkForAPIKey()
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&exclude=minutely,alerts&appid=\(API.key)&units=metric"
        apiService.getJSON(urlString: urlString) { (result: Result<WeatherDataModel, APIService.APIError>) in
            switch result {
            case .success(let result):
                DispatchQueue.main.async { [weak self] in
                    self?.current = result.current
                    self?.daily = result.daily
                    self?.hourly = result.hourly
                    self?.isLoading = false
                    print(result.current)
                }
            case .failure(let apiError):
                print("mansaError: \(apiError.localizedDescription)")
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.appError = AppError(errorString: "\(result)")
                }
            }
        }
    }
    
    
    
    func getCityName() {
        if let location = locationManager.location {
            CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
                if let newLocation = placemarks?.last?.locality {
                    self.currentCityName = newLocation
                }
            }
        }
    }
}

extension WeatherViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        requestLocation()
    }
    
    private func requestLocation() {
        guard CLLocationManager.locationServicesEnabled() else { return }
        
        switch locationAuthorizationStatus() {
        case .notDetermined, .authorizedAlways, .authorizedWhenInUse:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestLocation()
        case .restricted: break
        case .denied: showAlert = true; isLoading = false
        @unknown default: break
        }
    }
    
    func locationAuthorizationStatus() -> CLAuthorizationStatus {
        let locationManager = CLLocationManager()
        var locationAuthorizationStatus : CLAuthorizationStatus
        if #available(macCatalyst 14.0, *), #available(iOS 14.0, *) {
            locationAuthorizationStatus =  locationManager.authorizationStatus
        } else {
            // Fallback on earlier versions
            locationAuthorizationStatus = CLLocationManager.authorizationStatus()
        }
        return locationAuthorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        getWeather()
        getCityName()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.isLoading = false
        print(error.localizedDescription)
    }
}
