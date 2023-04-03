//
//  NetworkingManager.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-03.
//

import Foundation
import SwiftUI
import Combine

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
    
    static func downloadFromURL(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    static func download(apiRequest: String, language: String, parameters: [String : Any]?) -> AnyPublisher<Data, Error> {
        // Define the URL and Authorization header
        let requestUrl = URL(string: apiRequest)!
        
        var url = requestUrl
        // Define the API key
        let apiKey = "GA5koDndjlPCwf6ib(qEYC59isitwqIqV9iG3ILU(YtO60qz4fTBXm2kjq1SmpIJ02TiYh7KQYn((NC)T5B71jG=====2" 

        // Create the URL with the parameters and API key
        if let parameters = parameters {
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value as? String) }
            url = urlComponents.url!
        } else {
            let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            url = urlComponents.url!
        }
       
        // Create a URLSession with the API key header
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(apiKey)",
                                               "Content-Type": "application/json",
                                               "Accept-Language": language]
        let session = URLSession(configuration: configuration)
        
        return session.dataTaskPublisher(for: url)
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            .retry(1)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        //print("\(output)")
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
