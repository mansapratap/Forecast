//
//  ForecastApp.swift
//  Forecast
//
//  Created by Mansa Pratap Singh on 31/05/21.
//

import SwiftUI

@main
struct ForecastApp: App {
    
    // MARK: - Properties
    @StateObject var weatherVM = WeatherViewModel()
    
    // Alert Meaasage related to location Authorization status denied.
    private let message = NSLocalizedString("Go to Setting >> Privacy >> Location Services >> ForecastApp >> Ask Next Time", comment: "Location services are denied")
    private let settingsButtonTitle = NSLocalizedString("GO TO SETTINGS", comment: "Settings alert button")
    
    // MARK: - Root Window Body
    var body: some Scene {
        WindowGroup {
            ZStack {
                // Bottom Most layer bacground color gradient.
                LinearGradient(gradient: Gradient(colors: [Color("BottomBG"), Color("TopBG")]), startPoint: .topLeading, endPoint: .bottomLeading).ignoresSafeArea()
                if weatherVM.isLoading {
                    // Loading indicator when app launches..
                    ProgressView("Loading").font(.largeTitle)
                } else {
                    if weatherVM.showAlert {
                        ContentView()
                            // Alert on location denied.
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
                            // Alert when Network Error, Connection Error or API Key error etc.
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
