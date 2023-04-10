//
//  PlaceModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-09.
//

import SwiftUI
import MapKit

struct PlaceItemResult: Codable {
    let result: PlaceItemModel
}

struct PlaceItemModel: Codable,Identifiable {
    let placeId: String
    let placeName: String
    let latitude: Double?
    let longitude: Double?
    let mapCode: String?
    let sha: SHA
    let placeInformation: PlaceInformation
    let location: Location
    let contact: ContactInfo
    let thumbnailUrl: String
    let webPictureUrls: [String]?
    let mobilePictureUrls: [String]?
    let facilities: [Facility]?
    let services: [Service]?
    let paymentMethods: [PaymentMethod]?
    let openingHours: BusinessHours?
    let howToTravel: String?
    let destination: String?
    let tags: [String]?
    let standard: String?
    let awards: [String]?
    let rooms: [String]?
    let hitScore: Double?
    let updateDate: String?
    
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
        case openingHours = "opening_hours"
        case howToTravel = "how_to_travel"
        case destination
        case tags
        case standard
        case awards
        case rooms
        case hitScore = "hit_score"
        case updateDate = "update_date"
    }
    
    var id: String {
        placeId
    }
    
    func isHasLocation() -> Bool {
        return (latitude != nil && longitude != nil)
    }
    
    func getCoordinate() -> CLLocationCoordinate2D {
        if let latitude = latitude, let longitude = longitude {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            return CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
    }
}
