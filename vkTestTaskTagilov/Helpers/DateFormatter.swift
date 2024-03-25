//
//  DateFormatter.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 20.03.2024.
//

import Foundation

extension DateFormatter {
    static func getDayOfWeek(unixTime: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
        let dateFormatter = DateFormatter()
        
        if Calendar.current.isDateInToday(date) {
            return "Сегодня"
        } else if Calendar.current.isDateInTomorrow(date) {
            return "Завтра"
        } else {
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter.string(from: date)
        }
    }
    
    static func getDay(unixTime: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        return dateFormatter.string(from: date)
    }
}
