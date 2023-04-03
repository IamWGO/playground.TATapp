//
//  LocationModel.swift
//  tourismthailand
//
//  Created by Waleerat Gottlieb on 2023-03-27.
//

import Foundation

struct OpeningHours: Codable {
    let openNow: Bool
    let periods: [Period]
    let weekdayText: WeekdayText
    let specialCloseText: String
    
    enum CodingKeys: String, CodingKey {
        case openNow = "open_now"
        case periods
        case weekdayText = "weekday_text"
        case specialCloseText = "special_close_text"
    }
}

struct Period: Codable {
    let open: Open
    let close: Close
}

struct Open: Codable {
    let day: Int
    let time: String
}

struct Close: Codable {
    let day: Int
    let time: String
}

struct WeekdayText: Codable {
    let day1: Day
    let day2: Day
    let day3: Day
    let day4: Day
    let day5: Day
    let day6: Day
    let day7: Day
    
    struct Day: Codable {
        let day: String
        let time: String
    }
}

