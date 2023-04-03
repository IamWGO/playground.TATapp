//
//  RouteModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-04.
//

import Foundation

struct RouteListModel: Codable {
    let result: [Route]
}

struct RouteDetailModel: Decodable {
    let result: RouteDetail
}

struct Route: Codable {
    let routeId: String
    let routeName: String
    let routeIntroduction: String
    let numberOfDays: Int
    let thumbnailUrl: String?
    let distance: Double
    
    enum CodingKeys: String, CodingKey {
        case routeId = "route_id"
        case routeName = "route_name"
        case routeIntroduction = "route_introduction"
        case numberOfDays = "number_of_days"
        case thumbnailUrl = "thumbnail_url"
        case distance
    }
    
    var id: String {
        routeId
    }
}

struct RouteDetail: Decodable {
    let route_id: String
    let route_name: String
    let number_of_days: Int
    let days: [DayDetails]
}

struct DayDetails: Decodable {
    let day: Int
    let place_stops: [PlaceDetails]
}

struct PlaceDetails: Decodable {
    let place_id: String
    let place_name: String
    let latitude: Double
    let longitude: Double
    let category_code: String
    let category_description: String
    let place_introduction: String
    let thumbnail_url: String
    let travel_by: String
    let distance: Double
    let compressed_path: String
    
    enum CodingKeys: String, CodingKey {
        case place_id, place_name, latitude, longitude, category_code, category_description, place_introduction, thumbnail_url, travel_by, distance, compressed_path
    }
}

enum CodingKeys: String, CodingKey {
    case route_id, route_name, number_of_days, days
}
