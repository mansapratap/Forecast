//
//  API.swift
//  Forecast
//
//  Created by Mansa Pratap Singh on 31/05/21.
//

import Foundation

struct API {
    static let key = "c2b3bfc6b5b182e24d754bbe667b3b45"
    
    static func checkForAPIKey() {
        precondition(API.key != "YourAPIKey", "Condition: \nEither your APIKey is invalid or you haven't filled it yet. \nPlease Fill Your APIKey")
    }
}
