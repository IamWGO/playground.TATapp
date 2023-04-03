//
//  AccommodationDetailModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-04.
//

import Foundation

struct AccommodationDetailModel: Codable {
    let result: AccommodationDetail
}

struct AccommodationDetail: Codable {
    let placeId: String
    let placeName: String
    let latitude: Double
    let longitude: Double
    let sha: SHA
    let placeInformation: Accommodation
    let location: Location
    let contact: ContactInfo
    let thumbnailUrl: String
    let webPictureUrls: [String]
    let mobilePictureUrls: [String]
    let facilities: [Facility]
    let services: [String]?
    let paymentMethods: [PaymentMethod]
    let howToTravel: String
    let destination: String
    let tags: [String]?
    let standard: String
    let awards: [String]
    let updateDate: String
    let rooms: [String]?
    let hitScore: Double?
    
    enum CodingKeys: String, CodingKey {
        case placeId = "place_id"
        case placeName = "place_name"
        case latitude
        case longitude
        case sha
        case placeInformation = "place_information"
        case location
        case contact
        case thumbnailUrl = "thumbnail_url"
        case webPictureUrls = "web_picture_urls"
        case mobilePictureUrls = "mobile_picture_urls"
        case facilities
        case services
        case paymentMethods = "payment_methods"
        case howToTravel = "how_to_travel"
        case destination
        case tags
        case standard
        case awards
        case updateDate = "update_date"
        case rooms
        case hitScore = "hit_score"
    }
}
