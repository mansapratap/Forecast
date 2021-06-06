//
//  API.swift
//  Forecast
//
//  Created by Mansa Pratap Singh on 31/05/21.
//

import Foundation

struct API {
    static let key = "YourAPIKey"
    
    static func checkForAPIKey() {
        precondition(API.key != "YourAPIKey", "Condition: \nEither your APIKey is invalid or you haven't filled it yet. \nPlease Fill Your APIKey")
    }
}
