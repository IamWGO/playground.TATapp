//
//  PlaceSearchService.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-03.
//

import Foundation
import Combine

/**
 keyword    String    Required    A term to be matched with TAT place name, mapcode or latitude,longitude.
 location    String    Required    A GIS location of Latitude and Longitude in decimal degree. latitude is between -90 to 90 and longitude is between -180 and 180. For example: location=13.7222793,100.528923
 categorycodes    String    Optional    TAT ’s Place category such as "SHOP|ACCOMMODATION". All categories are separated using the pipe (|) character. Category for Filter support:
 • ALL = All Category,
 • OTHER = Other Place Type,
 • SHOP = Shopping Type,
 • RESTAURANT = Restaurant Type,
 • ACCOMMODATION = Hotel Type,
 • ATTRACTION = Attraction Type
 provinceName    String    Optional    Refer to province name in Thailand.
 radius    Decimal number    Optional    Defines the distance (in meter) within latitude (Lat) and longitude (Lon) parameter. Default value is 1,000 meters and Maximum value is 200,000 meters.
 numberOfResult    Integer    Optional    Number of record to return per/page. Default value is "50" and Maximum value is "100".
 pagenumber    Integer    Optional    Number of Page. Default is 1.
 destination    String    Optional    Refer to destination name in TAT.
 updateDate    String    Optional    Filter by update date of value the POI. Matching regular expression pattern: “Sample : 2019/01/01-2019/09/30
 */

class PlaceSearchService {
    
    @Published var placeSearchItems: PlaceSearchModel? = nil
    @Published var language: String = "th"
    
    @Published var categorycodes:String = "RESTAURANT"
    @Published var keyword:String?
    @Published var location:String?
    @Published var provinceName:String?
    @Published var radius:Int?
    @Published var numberOfResult: Int?
    @Published var pagenumber: Int?
    @Published var destination:String?
    @Published var updateDate:String?
    
    @Published var parameters: [String:String] = [:]
    
    var subscription: AnyCancellable?
    
    init(){
        getPlaceSearch()
    }
    
    func getPlaceSearch() {
       //updateDate = "2019/09/01-2021/12/31"
        //location = "13.6904831,100.5226014"
        numberOfResult = 10
        pagenumber = 1
        
        parameters = getQueryParameter()
        
        print(parameters)
       
        subscription = NetworkingManager.download(apiRequest: ApiRequest.GetPlaceSearch, language: language, parameters: parameters)
           
            .decode(type: PlaceSearchModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetails) in
                self?.placeSearchItems = returnedCoinDetails
                self?.subscription?.cancel()
            })
        
    }
    
    
    func getQueryParameter() -> [String:String]{
        var query: [String:String] = [:]
        
        query["categorycodes"] = categorycodes
        
        if let keyword = keyword {
            query["keyword"] = keyword
        }
        if let location = location {
            query["location"] = location
        }
        if let provinceName = provinceName {
            query["provinceName"] = provinceName
        }
        if let radius = radius {
            query["radius"] = String(radius)
        }
        if let numberOfResult = numberOfResult {
            query["numberOfResult"] = String(numberOfResult)
        }
        if let pagenumber = pagenumber {
            query["pagenumber"] = String(pagenumber)
        }
        if let destination = destination {
            query["destination"] = destination
        }
        if let updateDate = updateDate {
            query["updateDate"] = updateDate
        }
        
        return query
        
    }
    
}
