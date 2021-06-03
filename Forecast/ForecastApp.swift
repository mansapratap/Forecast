//
//  ForecastApp.swift
//  Forecast
//
//  Created by Mansa Pratap Singh on 31/05/21.
//

import SwiftUI

@main
struct ForecastApp: App {
    
    @StateObject var weatherVM = WeatherViewModel()
    
    let message = NSLocalizedString("Go to Setting >> Privacy >> Location Services >> ForecastApp >> Ask Next Time", comment: "Location services are denied")
    let settingsButtonTitle = NSLocalizedString("GO TO SETTINGS", comment: "Settings alert button")
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("BottomBG"), Color("TopBG")]), startPoint: .topLeading, endPoint: .bottomLeading).ignoresSafeArea()
                if weatherVM.isLoading {
                    ProgressView("Loading").font(.largeTitle)
                } else {
                    if weatherVM.showAlert {
                        ContentView()
                            .alert(isPresented: $weatherVM.showAlert) {
                                Alert(title: Text(NSLocalizedString("LOCATION SERVICES DENIED LAST TIME", comment: "Location services alert title")),
                                      message: Text(message),
                                      primaryButton: .default(Text(settingsButtonTitle)) {
                                        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                                            // Take the user to the Settings app to change permissions.
                                            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                                        }
                                      },secondaryButton: .cancel()
                                )
                            }
                    } else {
                        ContentView()
                            .alert(item: $weatherVM.appError) { (appAlert) in
                                Alert(title: Text("Error"), message: Text(
                                        """
                                \(appAlert.errorString)
                                Please try again later.
                                """)
                                )
                            }
                    }
                }
            }
        }
    }
}
