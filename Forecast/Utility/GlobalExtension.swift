//
//  GlobalExtension.swift
//  Forecast
//
//  Created by Mansa Pratap Singh on 05/06/21.
//

import Foundation

// MARK: - Integer To Date Extension
extension Int {
    var dayDateMonth: String {
        let dateFormatter = DateFormatter ()
        dateFormatter.dateFormat = "EE, MMM d"
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(self)))
    }
    
    func hourMinuteAmPm(_ offset: Int = 0) -> String {
        let dateFormatter = DateFormatter ()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Because API provider use GMT 00:00 as default TimeZone.
        // Or dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(self.advanced(by: offset))))
    }
}

// MARK: - Double Extension
extension Double {
    func roundedString(to digits: Int) -> String {
        String(format: "%.\(digits)f", self)
    }
}
