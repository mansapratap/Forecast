//
//  SearchView.swift
//  Forecast
//
//  Created by Mansa Pratap Singh on 05/06/21.
//

import SwiftUI

struct SearchView: View {
    @StateObject var weatherVM: WeatherViewModel
    
    var body: some View {
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
    }
}
