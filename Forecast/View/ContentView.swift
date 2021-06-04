//
//  ContentView.swift
//  Forecast
//
//  Created by Mansa Pratap Singh on 31/05/21.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Property
    @StateObject var weatherVM = WeatherViewModel()
    
    // MARK: - Body
    var body: some View {
        if weatherVM.isLoading {
            ProgressView("Loading").font(.largeTitle)
        } else {
            VStack {
                // MARK: - SearchView
                HStack {
                    Button {
                        weatherVM.getWeather()
                    } label: {
                        Image(systemName: "location.circle.fill").renderingMode(.original)
                            .font(.system(size: 24))
                    }
                    
                    TextField("Search City", text: $weatherVM.searchedCityName, onCommit:  {
                        weatherVM.fetchWeatherByCityName()
                    })
                    .padding(5)
                    .background(Color(.quaternarySystemFill))
                    .cornerRadius(8)
                    Button {
                        weatherVM.fetchWeatherByCityName()
                        hideKeyboard()
                    } label: {
                        Image(systemName: "magnifyingglass").renderingMode(.original)
                            .font(.system(size: 24))
                    }
                }
                .padding(.horizontal)
                
                // MARK: - Current View
                if let current = weatherVM.current {
                    VStack(spacing: 2) {
                        Text(weatherVM.currentCityName)
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                        HStack {
                            Text(current.weather[0].description.capitalized)
                            Divider()
                            Divider()
                            Text("Feels Like: \(current.feels_like.roundedString(to: 0))°")
                        }.fixedSize()
                        HStack {
                            Text("\(current.temp.roundedString(to: 0))°")
                            Divider()
                            Divider()
                            Image(systemName: current.weather[0].iconImage).renderingMode(.original)
                        }.fixedSize().font(.system(size: 75)).padding()
                        HStack {
                            Text("Cloud: \((current.clouds))%")
                            Divider()
                            Text("Humidity: \(current.humidity)%")
                        }.fixedSize()
                    }
                }
                
                ScrollView(showsIndicators: false) {
                    // MARK: - Daily View
                    if let daily = weatherVM.daily {
                        Divider()
                        VStack(alignment: .leading) {
                            Text("Daily Forecast").bold()
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(daily, id: \.dt) { day in
                                        ZStack {
                                            VStack {
                                                Text(daily[0].dt == day.dt ? "Today": day.dt.dayDateMonth).font(.title)
                                                HStack {
                                                    Text("Max \(day.temp.max.roundedString(to: 0))°")
                                                    Divider()
                                                    Divider()
                                                    Text("Min \(day.temp.min.roundedString(to: 0))°")
                                                }
                                                Image(systemName: day.weather[0].iconImage)
                                                    .renderingMode(.original)
                                                    .font(.system(size: 25))
                                                    .padding(4)
                                                HStack {
                                                    Text("Rain: \((day.pop * 100).roundedString(to: 0))%")
                                                    Divider()
                                                    Divider()
                                                    Text("Cloud: \(day.clouds)%")
                                                }
                                            }.padding()
                                        }
                                        .background(Color(.red).opacity(0.35))
                                        .cornerRadius(12)
                                    }
                                }
                            }
                        }.padding(.horizontal,8)
                    }
                    
                    // MARK: - Hourly View
                    if let hourly = weatherVM.hourly {
                        Divider()
                        VStack(alignment: .leading) {
                            Text("Hourly Forecast").bold()
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(hourly, id: \.dt) { hour in
                                        ZStack {
                                            VStack {
                                                Text(hour.dt.hourMinuteAmPm(weatherVM.timeZoneOffset)).font(.title)
                                                HStack {
                                                    Text("\(hour.temp.roundedString(to: 0))°")
                                                    Divider()
                                                    Divider()
                                                    Image(systemName: hour.weather[0].iconImage).renderingMode(.original)
                                                }
                                                .font(.system(size: 24))
                                                .padding()
                                                HStack {
                                                    Text("Rain: \((hour.pop * 100).roundedString(to: 0))%")
                                                    Divider()
                                                    Divider()
                                                    Text("Cloud: \(hour.clouds)%")
                                                }
                                            }.padding()
                                        }
                                        .background(Color(.systemPink).opacity(0.25))
                                        .cornerRadius(12)
                                    }
                                }
                            }
                        }.padding(.horizontal, 8)
                    }
                    
                    // MARK: - Current Detail View
                    if let current = weatherVM.current {
                        Divider()
                        VStack(alignment: .leading) {
                            HStack {
                                VStack(alignment: .leading) {
                                    DetailCell(title: "Sunrise", detail: "\(current.sunrise.hourMinuteAmPm(weatherVM.timeZoneOffset))")
                                    DetailCell(title: "Pressure", detail: "\(current.pressure) hPa")
                                    DetailCell(title: "Visibility", detail: "\(current.visibility/1000) Km")
                                }
                                Divider()
                                VStack(alignment: .leading) {
                                    DetailCell(title: "Sunset", detail: "\(current.sunset.hourMinuteAmPm(weatherVM.timeZoneOffset))")
                                    DetailCell(title: "Wind", detail: "\(current.windSpeedWithDirection)")
                                    DetailCell(title: "UV Index", detail: current.uvi.roundedString(to: 0))
                                }
                            }
                        }.padding(.horizontal)
                    }
                }
            }.animation(.easeInOut(duration: 1))
        }
    }
}

// MARK: - Content Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - Extension for Keyboard
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
