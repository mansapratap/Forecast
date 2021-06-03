//
//  ContentView.swift
//  Forecast
//
//  Created by Mansa Pratap Singh on 31/05/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var weatherVM = WeatherViewModel()
    
    var body: some View {
        if weatherVM.isLoading {
            ProgressView("Loading").font(.largeTitle)
        } else {
            ZStack {
                VStack {
                    SearchView()
                    CurrentView()
                    ScrollView(showsIndicators: false) {
                        DailyView()
                        HourView()
                        DetailView()
                    }
                }
            }.animation(.easeInOut(duration: 1))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
