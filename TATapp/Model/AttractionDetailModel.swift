//
//  AttractionDetailModel.swift
//  tourismthailand
//
//  Created by Waleerat Gottlieb on 2023-03-27.
//

import Foundation

struct AttractionDetailModel: Codable {
    let result: PlaceResult
}

struct PlaceResult: Codable {
    let placeId: String
    let placeName: String
    let latitude: Double
    let longitude: Double
    let mapCode: String?
    let sha: ShaModel
    let placeInformation: PlaceInformation
    
    enum CodingKeys: String, CodingKey {
        case placeId = "place_id"
        case placeName = "place_name"
        case latitude
        case longitude
        case mapCode = "map_code"
        case sha
        case placeInformation = "place_information"
    }
}


struct PlaceInformation: Codable {
    let introduction: String
    let detail: String
}
