//
//  ApiRequest.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-05.
//

import Foundation

enum ApiRequest {
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

enum ParmeterOfRequest {
    case PlaceSearch
    case EventList
    case RouteList
    case SHASearch
}

enum SearchType: String {
    case ALL //All Category,
    case OTHER //Other Place Type,
    case SHOP //Shopping Type,
    case RESTAURANT //Restaurant Type,
    case ACCOMMODATION //Hotel Type,
    case ATTRACTION //Attraction Type
    
    var value: String {
        return self.rawValue
    }
}

enum SHAType: String {
    case ALL // All Types,
    case SHOP // Department store And shopping centers,
    case RESTAURANT // Restaurants / diners,
    case ACCOMMODATION // Hotel / accommodation and meeting place,
    case ATTRACTION // Recreational activity and tourist attraction,
    case TRANSPORTATION // Transportation,
    case TRAVEL_AGENCY // Travel agency,
    case HEALTH_BEAUTY // Health and Beauty,
    case SPORT // Sport for tourism,
    case ACTIVITY_ENTERTAINMENT // Activity/meeting, Theater/entertainment,
    case SOUVENIR // Souvenir shop and other shops
    
    var value: String {
        return self.rawValue
    }
}

enum SHAcategoriy: String {
    case ALL //All Types,
    case SHA //SHA,
    case SHA_PLUS //SHA Plus,
    case SHA_EXTRA_PLUS //SHA Extra+
    
    var value: String {
        return self.rawValue
    }
}
