//
//  RestaurantDetailModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-04.
//

import Foundation

struct RestaurantDetailModel: Codable {
    let result: RestaurantDetail
}

struct RestaurantDetail: Codable {
    let placeID: String
    let placeName: String
    let latitude: Double
    let longitude: Double
    let sha: SHA
    let placeInformation: RestaurantInfo
    let location: Location
    let contact: ContactInfo
    let thumbnailURL: String
    let webPictureURLs: [String]
    let mobilePictureURLs: [String]
    let paymentMethods: [PaymentMethod]
    let howToTravel: String
   let destination: String
    let standard: String
    let awards: [String]
    let updateDate: String
    let area: String
    
    enum CodingKeys: String, CodingKey {
        case placeID = "place_id"
        case placeName = "place_name"
        case latitude, longitude, sha
        case placeInformation = "place_information"
        case location
        case contact
        case thumbnailURL = "thumbnail_url"
        case webPictureURLs = "web_picture_urls"
        case mobilePictureURLs = "mobile_picture_urls"
        case paymentMethods = "payment_methods"
        case howToTravel = "how_to_travel"
        case updateDate = "update_date"
        case destination, standard, awards, area
       
    }
}
