//
//  ShopDetailModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-04.
//

import Foundation

//
//  ShopDetailModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-04.
//

import Foundation

struct ShopDetailModel: Codable {
    let result: ShopDetail
}

struct ShopDetail: Codable {
    let placeId: String
    let placeName: String
    let latitude: Double
    let longitude: Double
    let sha: SHA
    let placeInformation: ShopInformation
    let location: Location
    let contact: ContactInfo
    let thumbnailUrl: String
    let webPictureUrls: [String]?
    let mobilePictureUrls: [String]?
    let facilities: [String]?
    let services: [String]?
    let paymentMethods: [PaymentMethod]
    let howToTravel: String
    let openingHours: BusinessHours
    let destination: String
    let tags: [String]?
    let standard: String
    let awards: [String]
    let updateDate: String
    let hitScore: Double?
    
    enum CodingKeys: String, CodingKey {
        case placeId = "place_id"
        case placeName = "place_name"
        case latitude
        case longitude
        case sha
        case placeInformation = "place_information"
        case  location
        case contact
        case thumbnailUrl = "thumbnail_url"
        case webPictureUrls = "web_picture_urls"
        case mobilePictureUrls = "mobile_picture_urls"
        case facilities
        case services
        case paymentMethods = "payment_methods"
        case howToTravel = "how_to_travel"
        case openingHours = "opening_hours"
        case destination, tags, standard, awards
        case updateDate = "update_date"
        case hitScore = "hit_score"
    }
}

struct BusinessHours: Codable {
    let openNow: Bool?
    let periods: [BusinessPeriod]?
    let weekdayText: [String: String?]?
    let specialCloseText: String
    
    enum CodingKeys: String, CodingKey {
        case openNow = "open_now"
        case periods
        case weekdayText = "weekday_text"
        case specialCloseText = "special_close_text"
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
