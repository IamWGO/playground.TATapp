//
//  SHASearchModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-05.
//

import Foundation

struct SHASearchModel: Codable {
    let result: [SHAItem]
}

struct SHAItem: Codable {
    let placeID: String
    let name: String
    let latitude: Double
    let longitude: Double
    let categoryCode: String
    let categoryDescription: String
    let shaTypeCode: String
    let shaTypeDescription: String
    let shaCateID: String
    let shaCateDescription: String
    let location: Location
    let thumbnailURL: String
    let destination: String
    let tags: String?
    let distance: Double
    let updateDate: String

    enum CodingKeys: String, CodingKey {
        case placeID = "place_id"
        case name = "sha_name"
        case latitude
        case longitude
        case categoryCode = "category_code"
        case categoryDescription = "category_description"
        case shaTypeCode = "sha_type_code"
        case shaTypeDescription = "sha_type_description"
        case shaCateID = "sha_cate_id"
        case shaCateDescription = "sha_cate_description"
        case location
        case thumbnailURL = "thumbnail_url"
        case destination
        case tags
        case distance
        case updateDate = "update_date"
    }
}
