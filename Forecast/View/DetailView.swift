//
//  DetailView.swift
//  Forecast
//
//  Created by Mansa Pratap Singh on 01/06/21.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var weatherVM = WeatherViewModel()

    var body: some View {
        if let current = weatherVM.current {
            Divider()
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        DetailCell(title: "Sunrise", detail: "\(current.sunrise.hourMinuteAmPm)")
                        DetailCell(title: "Pressure", detail: "\(current.pressure) hPa")
                        DetailCell(title: "Visibility", detail: "\(current.visibility/1000) Km")
                    }
                    Divider()
                    VStack(alignment: .leading) {
                        DetailCell(title: "Sunset", detail: "\(current.sunset.hourMinuteAmPm)")
                        DetailCell(title: "Wind", detail: "\((current.wind_speed * 3.6).roundedString(to: 1)) Km")
                        DetailCell(title: "UV Index", detail: current.uvi.roundedString(to: 0))
                    }
                }
            }.padding(.horizontal)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

struct DetailCell: View {
    let title: String
    let detail: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.body).fontWeight(.light)
            Text(detail).bold()
        }
        Divider()
    }
}
