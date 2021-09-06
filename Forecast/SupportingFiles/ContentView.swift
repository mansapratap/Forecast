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
            ScrollView(showsIndicators: false) {
                VStack {
                    SearchView(weatherVM: weatherVM)
                    CurrentView(weatherVM: weatherVM)
                    ScrollView(showsIndicators: false) {
                        DailyView(weatherVM: weatherVM)
                        HourlyView(weatherVM: weatherVM)
                        DetailView(weatherVM: weatherVM)
                    }
                }.animation(.easeInOut(duration: 1))
            }
        }
    }
}

// MARK: - Content Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
