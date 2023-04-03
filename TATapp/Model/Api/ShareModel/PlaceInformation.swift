//
//  PlaceInformation.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-04.
//

import Foundation

struct PlaceInformation: Codable {
    let introduction: String
    let detail: String
    let attractionTypes: [AttractionType]?
    let shopTypes: [ShopType]?
    let activities: [String]?
    let fee: Fee?
    let targets: [String]?

    enum CodingKeys: String, CodingKey {
        case introduction
        case detail
        case attractionTypes = "attraction_types"
        case shopTypes = "shop_types"
        case activities
        case fee
        case targets
    }
}

struct ShopType: Codable {
    let code, description: String
}

struct Facility: Codable {
    let code: String
    let description: String
}

struct PaymentMethod: Codable {
    let code: String
    let description: String
}
