//
//  ApiRequest.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-05.
//

import Foundation

enum APIStats {
    case GetPlaceSearch
    case GetAttractionDetail(placeId: String)
    case GetAccommodationDetail(placeId: String)
    case GetRestaurantDetail(placeId: String)
    case GetShopDetail(placeId: String)
    case GetPlaceOtherDetail(placeId: String)
    case GetEventList
    case GetEventDetail(eventId: String)
    case GetRecommendedRouteList
    case GetRecommendedRouteDetail(routeId: String)
    case GetSHASearch
    case GetSHADetail(placeId: String)
    /*
     case GetNewsList
     case GetNewsDetail(newsId: String)
     case PostChatbotPrediction
     case PostChatbotSendMessage
     */
    
    var url: String {
        return "https://tatapi.tourismthailand.org/tatapi/v5"
    }
    
    var path: String {
        switch self {
        case .GetPlaceSearch:                       return url + "/places/search"
        case .GetAttractionDetail(let placeId):     return url + "/attraction/\(placeId)"
        case .GetAccommodationDetail(let placeId):  return url + "/accommodation/\(placeId)"
        case .GetRestaurantDetail(let placeId):     return url + "/restaurant/\(placeId)"
        case .GetShopDetail(let placeId):           return url + "/shop/\(placeId)"
        case .GetPlaceOtherDetail(let placeId):     return url + "/other/\(placeId)"
        case .GetEventList:                         return url + "/events"
        case .GetEventDetail(let eventId):          return url + "/events/\(eventId)"
        case .GetRecommendedRouteList:              return url + "/routes"
        case .GetRecommendedRouteDetail(let routeId): return url + "/routes/\(routeId)"
        case .GetSHASearch:                         return url + "/places/sha"
        case .GetSHADetail(let placeId):            return url + "/sha/\(placeId)"
        /*
        case .GetNewsList:                          return url + "/news"
        case .GetNewsDetail(let newsId):            return url + "/news/\(newsId)"
        case .PostChatbotPrediction:                return url + "/chatbot/predict"
        case .PostChatbotSendMessage:               return url + "/chatbot/sendmessage"*/
        }
    }
}
