//
//  PlaceSearchService.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-03.
//

import Foundation
import Combine
import SwiftUI

enum QueryParameters {
    case PlaceSearch
    case EventList
    case RouteList
    case SHASearch
}

class RequestApiService {
    @AppStorage("language") private var language: String = "TH"
   
    @Published var placeSearchItems: PlaceSearchModel? = nil
    @Published var placeNearByItems: PlaceSearchModel? = nil
    
    @Published var selectedPlaceDetail: PlaceItemResult? = nil
    
    @Published var eventList: EventListModel?  = nil
    @Published var eventDetail: EventDetailModel?  = nil
    @Published var routeList: RouteListModel?  = nil
    @Published var routeDetail: RouteDetailModel?  = nil
    @Published var shaSearchItems: SHASearchModel?  = nil
    @Published var shaDetail: SHADetailModel?  = nil
    
    //GetPlaceSearch
    @Published var categorycodes:String?
    @Published var keyword:String?
    @Published var provinceName:String?
    @Published var radius:Int?
    @Published var destination:String?
    @Published var geolocation:String?
    @Published var sortby:String?  // distance or distance[default]
    // Route Search
    @Published var day: Int?
    // SHA Search
    @Published var shatype:String?
    @Published var provincename:String?
    @Published var searchradius:Double?
    @Published var numberofresult:Int? // only Shan search
    @Published var shacategories:String?
    
    @Published var pagenumber: Int?
    @Published var numberOfResult: Int? // place search and eventlist
    @Published var filterByUpdateDate:String?
    
    @Published var parameters: [String:String] = [:]
    
    var subscription: AnyCancellable? 
    var nearbySubscription: AnyCancellable?
    
    func getPlaceSearch() {
        parameters = getQueryParameter(parmeterOfRequest: .PlaceSearch)
        
        let apiRequest = APIStats.GetPlaceSearch.path
        subscription = NetworkingManager.download(apiRequest: apiRequest, language: language, parameters: parameters)
            .decode(type: PlaceSearchModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (result) in
                self?.placeSearchItems = result
                self?.subscription?.cancel()
            })
        
    }
    
    func getPlaceNearBy() {
        parameters = getQueryParameter(parmeterOfRequest: .PlaceSearch)
        
        let apiRequest = APIStats.GetPlaceSearch.path
        subscription = NetworkingManager.download(apiRequest: apiRequest, language: language, parameters: parameters)
            .decode(type: PlaceSearchModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (result) in
                self?.placeNearByItems = result
                self?.subscription?.cancel()
            })
        
    }
    
    /**
     Get Attraction Details. Additional information about specified location such as open-close time, telephone number, email, etc.
     
    - **HTTP Request** https://tatapi.tourismthailand.org/tatapi/v5/attraction/{place_id}
   
    - **HTTP Header**
         - *Content-Type* : application/json, text/json
         - *Authorization* : Bearer {Your TAT API key}
         - *Accept-Language* : Display language support: "th" or "en"
     
     - Throws: None
     - Parameters:
        - place_id: String  ID of Place which are returned from TAT services for example 'PlaceSearch'
     */
    func getAttractionDetail(placeId: String){
        // placeId = "P03000001"
        let apiRequest = APIStats.GetAttractionDetail(placeId: placeId).path 
        subscription = NetworkingManager.download(apiRequest: apiRequest, language: language, parameters: nil)
            .decode(type: PlaceItemResult.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (result) in
                self?.selectedPlaceDetail = result
                self?.subscription?.cancel()
            })
        
    }

    /**
     Get Attraction Details. Additional information about specified location such as open-close time, telephone number, email, etc.
     
    - **HTTP Request** https://tatapi.tourismthailand.org/tatapi/v5/attraction/{place_id}
   
    - **HTTP Header**
         - *Content-Type* : application/json, text/json
         - *Authorization* : Bearer {Your TAT API key}
         - *Accept-Language* : Display language support: "th" or "en"
     
     - Return : AccommodationDetailModel
     - Parameters:
        - place_id: String  ID of Place which are returned from TAT services for example 'PlaceSearch'
     */
    func getAccommodationDetail(placeId: String){
         //placeId = "P02000001"
        let apiRequest = APIStats.GetAccommodationDetail(placeId: placeId).path
        subscription = NetworkingManager.download(apiRequest: apiRequest, language: language, parameters: nil)
            .decode(type: PlaceItemResult.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (result) in
                self?.selectedPlaceDetail = result
                self?.subscription?.cancel()
            })
    }
    
    func getRestaurantDetail(placeId: String){
        let apiRequest = APIStats.GetRestaurantDetail(placeId: placeId).path
        subscription = NetworkingManager.download(apiRequest: apiRequest, language: language, parameters: nil)
            .decode(type: PlaceItemResult.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (result) in
                self?.selectedPlaceDetail = result
                self?.subscription?.cancel()
            })
        
    }
    
    func getShopDetail(placeId: String){
        let apiRequest = APIStats.GetShopDetail(placeId: placeId).path
        subscription = NetworkingManager.download(apiRequest: apiRequest, language: language, parameters: nil)
            .decode(type: PlaceItemResult.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (result) in
                self?.selectedPlaceDetail = result
                self?.subscription?.cancel()
            })
    }
    
    func getPlaceOtherDetail(placeId: String){
        let apiRequest = APIStats.GetPlaceOtherDetail(placeId: placeId).path
        subscription = NetworkingManager.download(apiRequest: apiRequest, language: language, parameters: nil)
            .decode(type: PlaceItemResult.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (result) in
                self?.selectedPlaceDetail = result
                self?.subscription?.cancel()
            })
    }
    
    // MARK: - Event
    func getEventList(){
        parameters = getQueryParameter(parmeterOfRequest: .EventList)
        
        let apiRequest = APIStats.GetEventList.path
        subscription = NetworkingManager.download(apiRequest: apiRequest, language: language, parameters: parameters)
            .decode(type: EventListModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (result) in
                self?.eventList = result
                self?.subscription?.cancel()
            })
    }
    
    func getEventDetail(eventId: String){
        let apiRequest = APIStats.GetEventDetail(eventId: eventId).path
        subscription = NetworkingManager.download(apiRequest: apiRequest, language: language, parameters: nil)
            .decode(type: EventDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (result) in
                self?.eventDetail = result
                self?.subscription?.cancel()
            })
    }
   // MARK: - RecommenedRute
    func getRecommendedRouteList(){
        parameters = getQueryParameter(parmeterOfRequest: .RouteList)
        
        let apiRequest = APIStats.GetRecommendedRouteList.path
        subscription = NetworkingManager.download(apiRequest: apiRequest, language: language, parameters: parameters)
            .decode(type: RouteListModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (result) in
                self?.routeList = result
                self?.subscription?.cancel()
            })
    }
    func getRecommendedRouteDetail(routeId: String){
        let apiRequest = APIStats.GetRecommendedRouteDetail(routeId: routeId).path
        subscription = NetworkingManager.download(apiRequest: apiRequest, language: language, parameters: nil)
            .decode(type: RouteDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (result) in
                self?.routeDetail = result
                self?.subscription?.cancel()
            })
    }
    // MARK: - SHA Search
    func getSHASearch(){
        parameters = getQueryParameter(parmeterOfRequest: .PlaceSearch)
        
        let apiRequest = APIStats.GetSHASearch.path
        subscription = NetworkingManager.download(apiRequest: apiRequest, language: language, parameters: parameters)
            .decode(type: SHASearchModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (result) in
                self?.shaSearchItems = result
                self?.subscription?.cancel()
            })
    }
    func getSHADetail(placeId: String){
        let apiRequest = APIStats.GetSHADetail(placeId: placeId).path
        subscription = NetworkingManager.download(apiRequest: apiRequest, language: language, parameters: nil)
            .decode(type: SHADetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (result) in
                self?.shaDetail = result
                self?.subscription?.cancel()
            })
    }
    
    func gostChatbotPrediction(){}
    func gostChatbotSendMessage(){}
    func getNewsList(){}
    func getNewsDetail(newsId: String){}
    
    // MARK: - Helper functions
    
    
    func getQueryParameter(parmeterOfRequest : QueryParameters) -> [String:String]{
        var query: [String:String] = [:]
        
        switch (parmeterOfRequest){
        case .PlaceSearch:
            if let categorycodes = categorycodes {
                query["categorycodes"] = categorycodes
            } else {
                 query["categorycodes"] = "RESTAURANT"
            }
            
            query["categorycodes"] = categorycodes
            if let keyword = keyword {  query["keyword"] = keyword }
            if let geolocation = geolocation { query["geolocation"] = geolocation }
            if let provinceName = provinceName { query["provinceName"] = provinceName }
            if let destination = destination { query["destination"] = destination }
            if let radius = radius { query["radius"] = String(radius) }
       
        case .EventList:
            if let geolocation = geolocation {  query["geolocation"] = geolocation }
            if let sortby = sortby { query["sortby"] = sortby }
        case .RouteList:
            if let day = day { query["day"] = String(day) }
        case .SHASearch:
            if let keyword = keyword {  query["keyword"] = keyword }
            if let geolocation = geolocation {  query["geolocation"] = geolocation }
            if let shatype = shatype {  query["shatype"] = shatype }
            if let provincename = provincename {  query["provincename"] = provincename }
            if let searchradius = searchradius {  query["searchradius"] = String(searchradius) }
            if let numberofresult = numberofresult {  query["numberofresult"] = String(numberofresult) }
            if let shacategories = shacategories {  query["shacategories"] = shacategories }
        }
        
        if let numberOfResult = numberOfResult {  query["numberOfResult"] = String(numberOfResult) }
        if let pagenumber = pagenumber {  query["pagenumber"] = String(pagenumber)}
        if let filterByUpdateDate = filterByUpdateDate {  query["filterByUpdateDate"] = filterByUpdateDate }
        return query
        
    }
    
    func clearAllQueryParameters(){
        categorycodes = nil
        keyword = nil
        provinceName = nil
        radius = nil
        destination = nil
        geolocation = nil
        sortby = nil  // distance or distance[default]
        day = nil
        shatype = nil
        provincename = nil
        searchradius = nil
        numberofresult = nil
        shacategories = nil
        pagenumber = nil
        numberOfResult = nil
        filterByUpdateDate = nil
    }
    
}


/**
This service allows you to search place information in TAT POI, You can query specified area by sending parameters, category or province name.

- **HTTP Request** https://tatapi.tourismthailand.org/tatapi/v5/places/search

- **HTTP Header**
    - *Content-Type* : application/json, text/json
    - *Authorization* : Bearer {Your TAT API key}
    - *Accept-Language* : Display language support: "th" or "en"
- **Example parameters**
    {
    "keyword":"อาหาร"
    "location":"13.6904831,100.5226014"
    "categorycodes":"RESTAURANT"
    "provinceName":"Bangkok"
    "radius":20
    "numberOfResult":10
    "pagenumber":1
    "destination":"Bangkok"
    "filterByUpdateDate":"2019/09/01-2021/12/31"
    }

- **Example Request URL**
 https://tatapi.tourismthailand.org/tatapi/v5/places/search?keyword=อาหาร&location=13.6904831,100.5226014&categorycodes=RESTAURANT&provinceName=Bangkok&radius=20&numberOfResult=10&pagenumber=1&destination=Bangkok&filterByUpdateDate=2019/09/01-2021/12/31
 
- Throws: None
- Parameters:
   - categorycodes: String  (ex : "RESTAURANT")
        • ALL = All Category,
        • OTHER = Other Place Type,
        • SHOP = Shopping Type,
        • RESTAURANT = Restaurant Type,
        • ACCOMMODATION = Hotel Type,
        • ATTRACTION = Attraction Type
           TAT ’s Place category such as "SHOP|ACCOMMODATION". All categories are separated using the pipe (|) character.
   - keyword :String?  A term to be matched with TAT place name, mapcode or latitude,longitude.
   - location: String? example: location=13.7222793,100.528923
   - provinceName: String?  Refer to province name in Thailand.
   - radius: Int? Decimal number    Optional    Defines the distance (in meter) within latitude (Lat) and longitude (Lon) parameter. Default value is 1,000 meters and Maximum value is 200,000 meters.
   - numberOfResult: Int? Number of record to return per/page. Default value is "50" and Maximum value is "100".
   - pagenumber: Int? Number of Page. Default is 1.
   - destination: String? Refer to destination name in TAT.
   - updateDate: String? Filter by update date of value the POI
- Returns: PlaceSearchModel
 
*/
