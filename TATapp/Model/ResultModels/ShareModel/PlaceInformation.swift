//
//  PlaceInformation.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-04.
//

import Foundation

struct PlaceInformation: Codable {
    let introduction: String
    let detail: String
    let accommodationTypes: [AccommodationType]?
    let attractionTypes: [AttractionType]?
    let restaurantTypes: [RestaurantTypes]?
    let shopTypes: [ShopType]?
    let registerLicenseId: String?
    let hotelStar: String?
    let displayCheckinTime: String?
    let displayCheckoutTime: String?
    let numberOfRooms: Int?
    let priceRange: String?
    let activities: [String]?
    let fee: TicketPrices?
    let targets: [String]?

    enum CodingKeys: String, CodingKey {
        case introduction
        case detail
        case accommodationTypes = "accommodation_types"
        case attractionTypes = "attraction_types"
        case restaurantTypes = "restaurant_types"
        case shopTypes = "shop_types"
        case registerLicenseId = "register_license_id"
        case hotelStar = "hotel_star"
        case displayCheckinTime = "display_checkin_time"
        case displayCheckoutTime = "display_checkout_time"
        case numberOfRooms = "number_of_rooms"
        case priceRange = "price_range"
        case activities
        case fee
        case targets
    }
}

struct AccommodationType: Codable {
    let code, description: String
}
struct ShopType: Codable {
    let code, description: String
}
struct RestaurantTypes: Codable {
    let code, description: String
}
struct AttractionType: Codable {
    let code, description: String
}
struct Facility: Codable {
    let code, description: String
}
struct PaymentMethod: Codable {
    let code, description: String
}

struct TicketPrices: Codable {
    let thaiChild: String
    let thaiAdult: String
    let foreignerChild: String
    let foreignerAdult: String
    
    enum CodingKeys: String, CodingKey {
        case thaiChild = "thai_child"
        case thaiAdult = "thai_adult"
        case foreignerChild = "foreigner_child"
        case foreignerAdult = "foreigner_adult"
    }
}


/*
 "opening_hours": {
             "open_now": null,
             "periods": null,
             "weekday_text": {
                 "day1": null,
                 "day2": null,
                 "day3": null,
                 "day4": null,
                 "day5": null,
                 "day6": null,
                 "day7": null
             },
             "special_close_text": ""
         },
 */


struct BusinessHours: Codable {
    let openNow: Bool?
    let periods: [BusinessPeriod]?
    let weekdayText: WeekdayText?
    let specialCloseText: String?
    
    enum CodingKeys: String, CodingKey {
        case openNow = "open_now"
        case periods
        case weekdayText = "weekday_text"
        case specialCloseText = "special_close_text"
    }
    
    struct WeekdayText: Codable {
        let day1: Day?
        let day2: Day?
        let day3: Day?
        let day4: Day?
        let day5: Day?
        let day6: Day?
        let day7: Day?
        
        struct Day: Codable {
            let day: String
            let time: String
        }
    }
    
    struct BusinessPeriod: Codable {
        let open: BusinessHour?
        let close: BusinessHour?
    }

    struct BusinessHour: Codable {
        let day: Int
        let time: String
    }
}


