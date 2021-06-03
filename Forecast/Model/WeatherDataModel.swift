//
//  WeatherDataModel.swift
//  Forecast
//
//  Created by Mansa Pratap Singh on 31/05/21.
//

import Foundation

struct WeatherDataModel: Codable {
    let timezone_offset: Int
    let current: Current
    let daily: [Daily]
    let hourly: [Hourly]
    
    struct Current: Codable {
        let dt: Int
        let sunrise: Int
        let sunset: Int
        let temp: Double
        let feels_like: Double
        let pressure: Int
        let humidity: Int
        let uvi: Double
        let clouds: Int
        let visibility: Int
        let wind_speed: Double
        let wind_deg: Int
        let weather: [Weather]
    }
    
    struct Hourly: Codable {
        let dt: Int
        let temp: Double
        let humidity: Int
        let clouds: Int
        let pop: Double
        let weather: [Weather]
    }
    
    struct Daily: Codable {
        let dt: Int
        let temp: Temp
        let clouds: Int
        let humidity: Int
        let pop: Double
        let weather: [Weather]
        
        struct Temp: Codable {
            let min: Double
            let max: Double
        }
    }
    
    struct Weather: Codable {
        let description: String
        let icon: String
    }
}

extension WeatherDataModel.Weather {
    var iconImage: String {
        switch icon {
        case "01d": return "sun.max.fill"
        case "01n": return "moon.stars.fill"
        case "02d": return "cloud.sun.fill"
        case "02n": return "cloud.moon.fill"
        case "03n", "03d": return "cloud.fill"
        case "04d", "04n": return "smoke.fill"
        case "09d", "09n": return "cloud.drizzle.fill"
        case "10d": return "cloud.sun.rain.fill"
        case "10n": return "cloud.moon.rain.fill"
        case "11d": return "cloud.sun.bolt.fill"
        case "11n": return "cloud.moon.bolt.fill"
        case "13d", "13n": return "snow"
        case "50d": return "sun.haze.fill"
        case "50n": return "cloud.fog.fill"
        default: return "cloud.fill"
        }
    }
}
extension Int {
    var makeString: String {
        "\(self)"
    }
    
    var dayDateMonth: String {
        let dateFormatter = DateFormatter ()
        dateFormatter.dateFormat = "EE, MMM d"
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(self)))
    }
    
    var hourMinuteAmPm: String {
        let dateFormatter = DateFormatter ()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(self)))
    }
}

extension Double {
    func roundedString(to digits: Int) -> String {
        String(format: "%.\(digits)f", self)
    }
}
