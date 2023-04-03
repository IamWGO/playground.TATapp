//
//  AttractionDetailModel.swift
//  tourismthailand
//
//  Created by Waleerat Gottlieb on 2023-03-27.
//

import Foundation
 
struct AttractionDetailModel: Codable {
    let result: AttractionDetail
}

struct AttractionDetail: Codable {
    let placeId: String
    let placeName: String
    let latitude: Double
    let longitude: Double
    let mapCode: String?
    let sha: SHA
    let placeInformation: PlaceInformation
    let location: Location
    let contact: ContactInfo
    let thumbnailUrl: String
    let webPictureUrls: [String]
    let mobilePictureUrls: [String]
    let facilities: [String]?
    let services: [String]?
    let paymentMethods: [String]?
    let howToTravel: String
    let openingHours: OpeningHours

    enum CodingKeys: String, CodingKey {
        case placeId = "place_id"
        case placeName = "place_name"
        case latitude
        case longitude
        case mapCode = "map_code"
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
        case openingHours = "opening_hours"
    }
    
    var id: String {
        placeId
    }
}





struct AttractionType: Codable {
    let code: String
    let description: String
}

struct Fee: Codable {
    let thaiChild: String?
    let thaiAdult: String?
    let foreignerChild: String?
    let foreignerAdult: String?

    enum CodingKeys: String, CodingKey {
        case thaiChild = "thai_child"
        case thaiAdult = "thai_adult"
        case foreignerChild = "foreigner_child"
        case foreignerAdult = "foreigner_adult"
    }
}

