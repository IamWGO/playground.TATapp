//
//  PlaceSearchModel.swift
//  tourismthailand
//
//  Created by Waleerat Gottlieb on 2023-03-26.
//

import Foundation

struct PlaceSearchModel: Codable {
    let result: [PlaceItemModel]
}

struct PlaceItemModel: Codable,Identifiable {
    let placeId: String
    let placeName: String
    let latitude: Double
    let longitude: Double
    let categoryCode: String
    let categoryDescription: String
    let sha: ShaModel
    let location: LocationModel
    let thumbnailUrl: String
    let destination: String
    let tags: String?
    let distance: Int
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
}
