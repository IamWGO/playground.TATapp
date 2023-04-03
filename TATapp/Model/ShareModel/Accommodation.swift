//
//  Accommodation.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-04.
//

import Foundation

struct Accommodation: Codable {
    let introduction: String
    let detail: String
    let accommodationTypes: [AccommodationType]
    let registerLicenseID: String
    let hotelStar: String
    let displayCheckinTime: String
    let displayCheckoutTime: String
    let numberOfRooms: Int
    let priceRange: String
    
    enum CodingKeys: String, CodingKey {
        case introduction
        case detail
        case accommodationTypes = "accommodation_types"
        case registerLicenseID = "register_license_id"
        case hotelStar = "hotel_star"
        case displayCheckinTime = "display_checkin_time"
        case displayCheckoutTime = "display_checkout_time"
        case numberOfRooms = "number_of_rooms"
        case priceRange = "price_range"
    }
}

struct AccommodationType: Codable {
    let code: String
    let description: String
}
