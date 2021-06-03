//
//  DailyView.swift
//  Forecast
//
//  Created by Mansa Pratap Singh on 01/06/21.
//

import SwiftUI

struct DailyView: View {
    
    @StateObject var weatherVM = WeatherViewModel()
    
    var body: some View {
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
    }
}

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView()
    }
}
