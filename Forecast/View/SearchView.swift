//
//  SearchView.swift
//  Forecast
//
//  Created by Mansa Pratap Singh on 01/06/21.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var weatherVM = WeatherViewModel()
    
    var body: some View {
        if weatherVM.current != nil {
            HStack {
                Button {
                    print("Location")
                } label: {
                    Image(systemName: "location.circle.fill").renderingMode(.original)
                        .font(.system(size: 24))
                }
                TextField("Search City", text: $weatherVM.cityName)
                    .padding(5)
                    .background(Color(.quaternarySystemFill))
                    .cornerRadius(8)
                Button {
                    weatherVM.fetchWeatherByCityName()
                } label: {
                    Image(systemName: "magnifyingglass").renderingMode(.original)
                        .font(.system(size: 24))
                }
            }
            .padding(.horizontal)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
