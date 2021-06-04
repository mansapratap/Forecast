//
//  AppError.swift
//  Forecast
//
//  Created by Mansa Pratap Singh on 02/06/21.
//

import Foundation

struct AppError: Identifiable {
    
    // MARK: - Properties
    let id = UUID().uuidString
    let errorString: String
}
