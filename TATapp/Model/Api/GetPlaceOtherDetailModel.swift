//
//  GetPlaceOtherDetailModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-04.
//

import Foundation

struct PlaceOtherDetailModel: Codable {
    let result: PlaceOtherDetail
}

struct PlaceOtherDetail: Codable {
    let place_id: String
    let place_name: String
    let latitude: Double
    let longitude: Double
    let sha: SHA
    let place_information: PlaceInformation
    let location: Location
    let contact: ContactInfo
    let thumbnail_url: String
    let web_picture_urls: [String]?
    let mobile_picture_urls: [String]?
    let destination: String
    let tags: [String]?
    let update_date: String
   
    struct PlaceInformation: Codable {
        let introduction: String
        let detail: String
        let place_type: String
    }
}
