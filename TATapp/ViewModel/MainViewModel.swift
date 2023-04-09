//
//  MainViewModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-03.
//

import Foundation
import Combine
import SwiftUI
import MapKit

class MainViewModel: ObservableObject {

    let requestService: RequestApiService
    // Api result parameters
    @Published var placeSearchItems: [PlaceItem]? = nil
    @Published var placeNearByItems: [PlaceItem]? = nil
    
    @Published var eventItems: [EventItem]?  = nil
    @Published var eventDetail: EventDetail? = nil
    @Published var routeItems: [Route]?  = nil
    @Published var routeDetail: RouteDetail? = nil
    @Published var shaSearchItems: [SHAItem]?  = nil
    @Published var shaDetail: SHADetail?  = nil
    
    //Select request api API
    @Published var currentState: RequestStates = RequestStates.Home
    //Use when select search category
    @Published var currentPlaceType: PlaceType? = nil
    @Published var currentPinLocation: String? = nil
    
    @Published var selectedplaceId: String? = nil
    @Published var selectedCategoryCode: String? = nil
    @Published var selectedPlaceDetail: PlaceItemModel?  = nil
    
    @Published var selectedEventId: String? = nil
    @Published var selectedRouteId: String? = nil
    
    // UI
    @Published var isShowCategotyMenu: Bool = false
    private var cancellables = Set<AnyCancellable>()

    init() {
        self.requestService = RequestApiService()
        self.currentState = RequestStates.Landing
        
        self.apiRequestPublisher()
        self.mainPublisher()
        
    }
    // MARK: - Combine
    func apiRequestPublisher() {
        requestService.$placeSearchItems
            .sink{ (result) in
                if let result = result {
                    self.placeSearchItems = result.result
                    print("** placeSearchItems =  \(result.result.count)")
                }
            }
            .store(in: &cancellables)
        
        requestService.$placeNearByItems
            .sink{ (result) in
                if let result = result {
                    self.placeNearByItems = result.result
                    print("** placeNearByItems = \(result.result.count)")
                }
            }
            .store(in: &cancellables)
       
         
        requestService.$selectedPlaceDetail
            .sink{ (result) in
                if let result = result {
                    self.selectedPlaceDetail = result.result
                    print("** attractionDetail = \(result.result.placeName)")
                }
            }
            .store(in: &cancellables)
       
        // MARK: - Event
        requestService.$eventList
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.eventItems = result.result
                    print("** eventList = \(result.result.count)")
                }
            }
            .store(in: &cancellables)
        
        requestService.$eventDetail
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.eventDetail = result.result
                    print("** eventDetail = \(result.result.eventName)")
                }
            }
            .store(in: &cancellables)
        // MARK: - Route
        requestService.$routeList
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.routeItems = result.result
                    print("** routeList = \(result.result.count)")
                }
            }
            .store(in: &cancellables)
        
        requestService.$routeDetail
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.routeDetail = result.result
                    print("** routeDetail = \(result.result.days)")
                }
            }
            .store(in: &cancellables)
       
        // MARK: - SHA
        requestService.$shaSearchItems
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.shaSearchItems = result.result
                    print("** shaSearchItems = \(result.result.count)")
                }
            }
            .store(in: &cancellables)
        
        requestService.$shaDetail
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.shaDetail = result.result
                    print("** shaDetail = \(result.result.shaName)")
                }
            }
            .store(in: &cancellables)
        
        
        
    }
    
    func mainPublisher(){
        $currentState.sink{ [weak self] (currentState) in
            print(">>> Current: \(currentState)")
            self?.getPreviewByUIState(currentState: currentState)
        }
        .store(in: &cancellables)
        
        $currentPlaceType.sink{ result in
            if let result = result {
                self.requestService.clearAllQueryParameters()
               
                if result != .EVENT {
                    self.requestService.categorycodes = result.value
                    self.currentState = RequestStates.GetPlaceSearch
                } else {
                    self.currentState = RequestStates.GetEventList
                }
                
                
            }
        }
        .store(in: &cancellables)
        
        $selectedPlaceDetail.sink{ result in
            if let placeItem = result {
                if let latitude = placeItem.latitude, let longitude = placeItem.longitude {
                    self.requestService.geolocation = "\(latitude),\(longitude)"
                    self.requestService.getPlaceNearBy()
                }
            }
        }
        .store(in: &cancellables)
        
    }
    
    // MARK: - Core UIStates
    func getTopSafeAreaSize() -> CGFloat{
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            return window.safeAreaInsets.top
        } else { return 0 }
    }
    
    // MARK: - Request STATE
    func setRequestStateForSearchPlace(placeType: PlaceType) {
        requestService.categorycodes = placeType.value
        currentState = RequestStates.GetPlaceSearch
    }
    
    func getPreviewByUIState(currentState: RequestStates){
        
        switch (currentState) {
        case .Landing: print("-> No query") // TODO : - Some query
        case .Home: requestService.getPlaceSearch()
        case .GetPlaceNearBy: requestService.getPlaceNearBy()
        case .GetPlaceSearch: requestService.getPlaceSearch()
        case .GetAttractionDetail:
            if let placeId = selectedplaceId {
                requestService.getAttractionDetail(placeId: placeId)
            }
            
        case .GetAccommodationDetail:
            if let placeId = selectedplaceId {
                requestService.getAccommodationDetail(placeId: placeId)
            }
        case .GetRestaurantDetail:
            if let placeId = selectedplaceId {
                requestService.getRestaurantDetail(placeId: placeId)
            }
        case .GetShopDetail:
            if let placeId = selectedplaceId {
                requestService.getShopDetail(placeId: placeId)
            }
        case .GetPlaceOtherDetail:
            if let placeId = selectedplaceId {
                requestService.getPlaceOtherDetail(placeId: placeId)
            }
        case .GetEventList: requestService.getEventList()
        case .GetEventDetail:
            if let eventId = selectedEventId {
                requestService.getEventDetail(eventId: eventId)
            }
       
        case .GetRecommendedRouteList: requestService.getRecommendedRouteList()
        case .GetRecommendedRouteDetail:
            if let routeId = selectedRouteId {
                requestService.getRecommendedRouteDetail(routeId: routeId)
            }
            
        case .GetSHASearch: requestService.getSHASearch()
        case .GetSHADetail:
            if let placeId = selectedplaceId {
                requestService.getSHADetail(placeId: placeId)
            }
            
        /*case .PostChatbotPrediction: break
        case .PostChatbotSendMessage: break
        case .GetNewsList: break
        case .GetNewsDetail: break*/
        
        }
    }
 
    // MARK: - UI Helper
    func getPlaceDetail(placeSearchItem: PlaceItem){
        selectedCategoryCode = placeSearchItem.categoryCode
        selectedplaceId = placeSearchItem.placeId
       
        switch(placeSearchItem.categoryCode) {
        case "OTHER": self.currentState = RequestStates.GetPlaceOtherDetail
        case "SHOP": self.currentState = RequestStates.GetShopDetail
        case "RESTAURANT": self.currentState = RequestStates.GetRestaurantDetail
        case "ACCOMMODATION": self.currentState = RequestStates.GetAccommodationDetail
        case "ATTRACTION": self.currentState = RequestStates.GetAttractionDetail
        default: break
        }
    }
    
    func getShaTypeDescription(sha: SHA) -> String {
        return "\(sha.shaTypeDescription)"
    }
    
    func getFullAddress(location: Location) -> String {
        var address = ""
        if (location.address != "") { address +=  "\(location.address) " }
        if (location.subDistrict != "") { address +=  "\(location.subDistrict) " }
        if (location.district != "") { address +=  "\(location.district) " }
        if (location.province != "") { address +=  "\(location.province) " }
        if (location.postcode != "") { address +=  "\(location.postcode) " }
        
        return address
    }
    
    func getDistrictAndProvince(location: Location) -> String {
        var address = ""
        if (location.district != "") { address +=  "\(location.district) " }
        if (location.province != "") { address +=  "\(location.province) " } 
        return address
    }
    
    func getContactNumbers(contacInfo: ContactInfo) -> String {
        return contacInfo.phones?[0] ?? ""
    }
    
    func toggleMenuIcon() {
        withAnimation(.easeInOut) {
            isShowCategotyMenu = !isShowCategotyMenu
        }
    }
    
    
    
   // MARK: - Location
    func setLanguage(language: String) {
        UserDefaultManager.set(forKey: "language", data: language)
    }
    
    func getLanguage() -> String {
        if UserDefaultManager.isExist(forKey: "language") {
            return UserDefaultManager.get(forKey: "language") as! String
        } else {
            UserDefaultManager.set(forKey: "language", data: "EN")
            return "EN"
        }
       
    }
    
   
}
 
