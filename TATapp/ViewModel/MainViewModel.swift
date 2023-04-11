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
    @Published var placeSearchItems: [PlaceSearchItem]? = nil
    @Published var placeNearByItems: [PlaceSearchItem]? = nil
    
    @Published var eventItems: [EventItem]?  = nil
    @Published var eventDetail: EventDetail? = nil
    @Published var routeItems: [Route]?  = nil
    @Published var routeDetail: RouteDetail? = nil
    @Published var shaSearchItems: [SHAItem]?  = nil
    @Published var shaDetail: SHADetail?  = nil
    
    //Select request api API
    @Published var currentState: RequestStates
    //Use when select search category
    @Published var currentPlaceType: PlaceSearchType? = nil
    @Published var currentPinLocation: String? = nil
    
    @Published var selectedplaceId: String? = nil
    @Published var selectedCategoryCode: String? = nil
    @Published var selectedPlaceDetail: PlaceItemModel?  = nil
    
    @Published var selectedEventId: String? = nil
    @Published var selectedRouteId: String? = nil
    
    // UI
    @Published var isShowCategotyMenu: Bool = false
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()

    init() {
        self.requestService = RequestApiService()
        self.currentState = RequestStates.None
        
        self.apiRequestPublisher()
        self.mainPublisher()
        
    }
    // MARK: - Combine
    func apiRequestPublisher() {
        requestService.$placeSearchItems
            .sink{ (result) in
                if let result = result {
                    self.placeSearchItems = result.result
                    self.isLoading = false
                    print("** placeSearchItems =  \(result.result.count)")
                }
            }
            .store(in: &cancellables)
        
        requestService.$placeNearByItems
            .sink{ (result) in
                if let result = result {
                    self.placeNearByItems = result.result
                    self.isLoading = false
                    print(">> placeNearByItems = \(result.result.count)")
                }
            }
            .store(in: &cancellables)
         
        requestService.$selectedPlaceDetail
            .sink{ (result) in
                if let result = result {
                    self.selectedPlaceDetail = result.result
                    self.isLoading = false
                    print("** attractionDetail = \(result.result.placeName)")
                }
            }
            .store(in: &cancellables)
       
        // MARK: - Event
        requestService.$eventList
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.eventItems = result.result
                    self?.isLoading = false
                    print("** eventList = \(result.result.count)")
                }
            }
            .store(in: &cancellables)
        
        requestService.$eventDetail
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.eventDetail = result.result
                    self?.isLoading = false
                    print("** eventDetail = \(result.result.eventName)")
                }
            }
            .store(in: &cancellables)
        // MARK: - Route
        requestService.$routeList
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.routeItems = result.result
                    self?.isLoading = false
                    print("** routeList = \(result.result.count)")
                }
            }
            .store(in: &cancellables)
        
        requestService.$routeDetail
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.routeDetail = result.result
                    self?.isLoading = false
                    print("** routeDetail = \(result.result.days)")
                }
            }
            .store(in: &cancellables)
       
        // MARK: - SHA
        requestService.$shaSearchItems
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.shaSearchItems = result.result
                    self?.isLoading = false
                    print("** shaSearchItems = \(result.result.count)")
                }
            }
            .store(in: &cancellables)
        
        requestService.$shaDetail
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.shaDetail = result.result
                    self?.isLoading = false
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
                    print("** requestService.getPlaceNearBy()")
                    self.requestService.geolocation = "\(latitude),\(longitude)"
                    self.currentState = RequestStates.GetPlaceNearBy
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
    func setRequestStateForSearchPlace(placeType: PlaceSearchType) {
        requestService.categorycodes = placeType.value
        currentState = RequestStates.GetPlaceSearch
    }
    
    func getPlaceDetail(placeSearchItem: PlaceSearchItem){
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
    
    private func getPreviewByUIState(currentState: RequestStates){
        
        isLoading = true
        
        switch (currentState) {
        case .None: print("-> No query") // TODO : - Some query
        case .GetPlaceNearBy:
            requestService.geolocation = "13.920694,100.600622"
            requestService.radius = 200000
            requestService.getPlaceNearBy()
        
        case .GetPlaceSearch: requestService.getPlaceSearch()
        case .GetAttractionDetail:
            if let placeId = selectedplaceId {
                requestService.getAttractionDetail(placeId: placeId)
            }
            
        case .GetAccommodationDetail:
            selectedplaceId = "P02000010"
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
    
    func getColorBySearchTypeCateogry(placeTypeString: String?) -> Color {
       
        guard let placeTypeString = placeTypeString else { return Color.theme.button }
        
        var placeType: PlaceSearchType = .ALL
        switch(placeTypeString) {
        case "OTHER": placeType = .OTHER
        case "SHOP": placeType = .SHOP
        case "RESTAURANT": placeType = .RESTAURANT
        case "ACCOMMODATION": placeType = .ACCOMMODATION
        case "ATTRACTION": placeType = .ATTRACTION
        default: return Color.theme.button
        }
        
        guard let currentType = searchTypeItems.first(where: { $0.placeType == placeType }) else {
            print("Could not find current index in locations array! Should never happen.")
            return Color.theme.button
        }
        
        return currentType.backgroundColor
    }
    
   
}
 
