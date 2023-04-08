//
//  PlaceSearchModel.swift
//  tourismthailand
//
//  Created by Waleerat Gottlieb on 2023-03-26.
//

import Foundation
import MapKit

struct PlaceSearchModel: Codable {
    let result: [PlaceItem]
}

struct PlaceItem: Codable,Identifiable,Equatable {
    static func == (lhs: PlaceItem, rhs: PlaceItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    let placeId: String
    let placeName: String
    let latitude: Double?
    let longitude: Double?
    let categoryCode: String
    let categoryDescription: String
    let sha: SHA
    let location: Location
    let thumbnailUrl: String
    let destination: String
    let tags: String?
    let distance: Double?
    let updateDate: String
    
    private enum CodingKeys: String, CodingKey {
        case placeId = "place_id"
        case placeName = "place_name"
        case latitude, longitude
        case categoryCode = "category_code"
        case categoryDescription = "category_description"
        case sha, location
        case thumbnailUrl = "thumbnail_url"
        case destination, tags, distance
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
            return CLLocationCoordinate2D(latitude: kDefaultLocation.latitude, longitude: kDefaultLocation.longitude)
        }
    }
  
}
