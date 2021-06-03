//
//  CurrentView.swift
//  Forecast
//
//  Created by Mansa Pratap Singh on 01/06/21.
//

import SwiftUI

struct CurrentView: View {
    
    @StateObject var weatherVM = WeatherViewModel()
    
    var body: some View {
        if let current = weatherVM.current {
            ZStack {
                VStack(spacing: 2) {
                    Text(weatherVM.currentCityName).font(.largeTitle)
                    HStack {
                        Text(current.weather[0].description.capitalized)
                        Divider()
                        Divider()
                        Text("Feels Like: \(current.feels_like.roundedString(to: 0))°")
                    }
                    HStack {
                        Text("\(current.temp.roundedString(to: 0))°")
                        Divider()
                        Divider()
                        Image(systemName: current.weather[0].iconImage).renderingMode(.original)
                    }
                    .font(.system(size: 75))
                    .padding()
                    HStack {
                        Text("Cloud: \((current.clouds))%")
                        Divider()
                        Text("Humidity: \(current.humidity)%")
                    }
                }.padding()
            }.fixedSize()
            .cornerRadius(15)
        }
    }
}

struct CurrentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentView()
    }
}
