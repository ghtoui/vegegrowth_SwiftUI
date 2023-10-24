//
//  DateFormatter.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/24.
//

import Foundation

class DateManager {
    private let dateFormatter = DateFormatter()
    
    init() {
        dateFormatter.dateFormat = L10n.dateFormat
        dateFormatter.locale = Locale(identifier: L10n.japanIdentifier)
    }
    
    func getDatetimeNow() -> String {
        return dateFormatter.string(from: Date())
    }
    
    func transDateFromString(dateText: String) -> Date? {
        return dateFormatter.date(from: dateText)
    }
    
    func transStringFromDate(date: Date?) -> String {
        guard let date else {
            return L10n.noneText
        }
        let dateText = dateFormatter.string(from: date)
        return dateText
    }
}
