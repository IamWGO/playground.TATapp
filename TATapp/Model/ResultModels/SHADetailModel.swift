//
//  SHADetailModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-05.
//

import Foundation

struct SHADetailModel: Codable {
    let result: SHADetail
}

struct SHADetail: Codable {
    let placeId: String
    let shaName: String
    let latitude: Double?
    let longitude: Double?
    let shaTypeCode: String
    let shaTypeDescription: String
    let shaCateId: String
    let shaCateDescription: String
    let shaDetail: String?
    let location: Location
    let contact: ContactInfo
    let openingHours: BusinessHours
    let thumbnailUrl: String
    let pictureUrls: [String]
    let updateDate: String
    let destination: String?
    let tags: [String]?
    let hitScore: Double?

    enum CodingKeys: String, CodingKey {
        case placeId = "place_id"
        case shaName = "sha_name"
        case latitude, longitude
        case shaTypeCode = "sha_type_code"
        case shaTypeDescription = "sha_type_description"
        case shaCateId = "sha_cate_id"
        case shaCateDescription = "sha_cate_description"
        case shaDetail = "sha_detail"
        case location, contact
        case openingHours = "opening_hours"
        case thumbnailUrl = "thumbnail_url"
        case pictureUrls = "picture_urls"
        case updateDate = "update_date"
        case destination, tags
        case hitScore = "hit_score"
    }
}
 
struct DayTime: Codable {
    let day: Int
    let time: String
}
struct DayText: Codable {
    let day: String
    let time: String
}
