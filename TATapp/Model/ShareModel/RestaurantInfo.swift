//
//  RestaurantInfo.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-04.
//

import Foundation

struct RestaurantInfo: Codable {
    let introduction: String
    let detail: String
    let restaurantTypes: [RestaurantType]
    let cuisineTypes: String?
    
    enum CodingKeys: String, CodingKey {
        case introduction
        case detail
        case restaurantTypes = "restaurant_types"
        case cuisineTypes = "cuisine_types"
    }
}

struct RestaurantType: Codable {
    let code: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case code
        case description
    }
}
