//
//  NetworkingManager.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-03.
//

import Foundation
import SwiftUI
import Combine

class NetworkingManager1 {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[🔥] Bad response from URL: \(url)"
            case .unknown: return "[⚠️] Unknown error occured"
            }
        }
    }
    
    static func download(url: URL, language: String, parameters: [String : String]) -> AnyPublisher<Data, Error> {

        // Define the API key
        let apiKey = "GA5koDndjlPCwf6ib(qEYC59isitwqIqV9iG3ILU(YtO60qz4fTBXm2kjq1SmpIJ02TiYh7KQYn((NC)T5B71jG=====2"

        // Create the URL with the parameters and API key
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        let url = urlComponents.url!
       
        // Create a URLSession with the API key header
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(apiKey)",
                                               "Accept-Language": language]
        let session = URLSession(configuration: configuration)
        
        return session.dataTaskPublisher(for: url)
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            .retry(1)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
      
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}




class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[🔥] Bad response from URL: \(url)"
            case .unknown: return "[⚠️] Unknown error occured"
            }
        }
    }
    
    
    
    static func download(apiRequest: ApiRequest, language: String, parameters: [String : Any]) -> AnyPublisher<Data, Error> {
        // Define the URL and Authorization header
        let requestUrl = URL(string: apiRequest.path)!
        
        var url = requestUrl
        // Define the API key
        let apiKey = "GA5koDndjlPCwf6ib(qEYC59isitwqIqV9iG3ILU(YtO60qz4fTBXm2kjq1SmpIJ02TiYh7KQYn((NC)T5B71jG=====2" 

        // Create the URL with the parameters and API key
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value as? String) }
        url = urlComponents.url!
       
        // Create a URLSession with the API key header
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(apiKey)",
                                               "Accept-Language": language]
        let session = URLSession(configuration: configuration)
        
        return session.dataTaskPublisher(for: url)
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            .retry(1)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
      
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}


enum ApiRequest: String {
    case GetPlaceSearch = "/places/search"
    case GetAttractionDetail = "/attraction/{place_id}"
    case GetAccommodationDetail = "/accommodation/{place_id}"
    case GetRestaurantDetail = "/restaurant/{place_id}"
    case GetShopDetail = "/shop/{place_id}"
    case GetPlaceOtherDetail = "/other/{place_id}"
    case GetEventList = "/events"
    case GetEventDetail = "/events/{event_id}"
    case GetNewsList = "/news"
    case GetNewsDetail = "/news/{news_id}"
    case GetRecommendedRouteList = "/routes"
    case GetRecommendedRouteDetail = "/routes/{route_id}"
    case PostChatbotPrediction = "/chatbot/predict"
    case PostChatbotSendMessage = "/chatbot/sendmessage"
    case GetSHASearch = "/places/sha"
    case GetSHADetail = "/sha/{place_id}"
    
    var path: String {
        let baseURL = "https://tatapi.tourismthailand.org/tatapi/v5"
        
        switch self {
        case .GetPlaceSearch: return baseURL + "/places/search"
        case .GetAttractionDetail: return baseURL + "/attraction/{place_id}"
        case .GetAccommodationDetail: return baseURL + "/accommodation/{place_id}"
        case .GetRestaurantDetail: return baseURL + "/restaurant/{place_id}"
        case .GetShopDetail: return baseURL + "/shop/{place_id}"
        case .GetPlaceOtherDetail: return baseURL + "/other/{place_id}"
        case .GetEventList: return baseURL + "/events"
        case .GetEventDetail: return baseURL + "/events/{event_id}"
        case .GetNewsList: return baseURL + "/news"
        case .GetNewsDetail: return baseURL + "/news/{news_id}"
        case .GetRecommendedRouteList: return baseURL + "/routes"
        case .GetRecommendedRouteDetail: return baseURL + "/routes/{route_id}"
        case .PostChatbotPrediction: return baseURL + "/chatbot/predict"
        case .PostChatbotSendMessage: return baseURL + "/chatbot/sendmessage"
        case .GetSHASearch: return baseURL + "/places/sha"
        case .GetSHADetail: return baseURL + "/sha/{place_id}"
        }
    }
}
