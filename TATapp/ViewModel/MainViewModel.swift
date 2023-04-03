//
//  MainViewModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-03.
//

import Foundation
import Combine
import SwiftUI

class MainViewModel: ObservableObject {

    let placeService: TATApiService
    
    @Published var placeSearchItems: [PlaceItem]? = nil
    @Published var placeDetails: AttractionDetail? = nil
    @Published var attractionDetail: AttractionDetail? = nil
    @Published var accommodationDetail: AccommodationDetail? = nil
    @Published var restaurantDetail: RestaurantDetail?  = nil
    @Published var shopDetail: ShopDetail?  = nil
    @Published var placeOtherDetail: PlaceOtherDetail?  = nil
    @Published var eventItems: [EventItem]?  = nil
    @Published var eventDetail: EventDetail? = nil
    @Published var routeItems: [Route]?  = nil
    @Published var routeDetail: RouteDetail? = nil
    @Published var shaSearchItems: [SHAItem]?  = nil
    @Published var shaDetail: SHADetail?  = nil
    
    @Published var currentState: UIStates = UIStates.Home
    @Published var currentPlaceType: PlaceType? = nil
    @Published var placeId: String? = nil
    @Published var eventId: String? = nil
    @Published var routeId: String? = nil
    
    
    // UI
    @Published var isShowCategotyMenu: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
     
    
    init() {
        self.placeService = TATApiService()
        self.currentState = UIStates.Landing
        self.getUIState()
    }
    
    // MARK: - Combine
    func getUIState() {
        $currentState.sink{ [weak self] (currentState) in
            self?.getPreviewByUIState(currentState: currentState)
        }
        .store(in: &cancellables)
        
        placeService.$placeSearchItems
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.placeSearchItems = result.result
                    print(result.result)
                }
            }
            .store(in: &cancellables)
        
        //placeId: String
        placeService.$attractionDetail
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.placeDetails = result.result
                    print(result.result)
                }
            }
            .store(in: &cancellables)
        
        placeService.$attractionDetail
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.attractionDetail = result.result
                    print(result.result)
                }
            }
            .store(in: &cancellables)
        
        
        placeService.$accommodationDetail
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.accommodationDetail = result.result
                    print(result.result)
                }
            }
            .store(in: &cancellables)
        
        placeService.$restaurantDetail
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.restaurantDetail = result.result
                    print(result.result)
                }
            }
            .store(in: &cancellables)
        
        placeService.$shopDetail
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.shopDetail = result.result
                    print(result.result)
                }
            }
            .store(in: &cancellables)
        
        placeService.$placeOtherDetail
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.placeOtherDetail = result.result
                    print(result.result)
                }
            }
            .store(in: &cancellables)
        
        placeService.$eventList
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.eventItems = result.result
                    print(result)
                }
            }
            .store(in: &cancellables)
        
        placeService.$eventDetail
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.eventDetail = result.result
                    print(result)
                }
            }
            .store(in: &cancellables)
        
        placeService.$routeList
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.routeItems = result.result
                    print(result)
                }
            }
            .store(in: &cancellables)
        
        placeService.$routeDetail
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.routeDetail = result.result
                    print(result)
                }
            }
            .store(in: &cancellables)
        
        placeService.$shaSearchItems
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.shaSearchItems = result.result
                    print(result)
                }
            }
            .store(in: &cancellables)
        
        placeService.$shaDetail
            .sink{ [weak self] (result) in
                if let result = result {
                    self?.shaDetail = result.result
                    print(result)
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
    
    func getPreviewByUIState(currentState: UIStates){
        
        switch (currentState) {
        case .Landing: print("-> No query") // TODO : - Some query
        case .Home: placeService.getPlaceSearch()
        case .Setting: print("-> No query") // TODO : - Some query
        case .GetPlaceSearch: placeService.getPlaceSearch()
        case .GetAttractionDetail:
            placeId = "P03000001"
            if let placeId = placeId {
                placeService.getAttractionDetail(placeId: placeId)
            }
        case .GetAccommodationDetail:
            placeId = "P02000001"
            if let placeId = placeId {
                placeService.getAccommodationDetail(placeId: placeId)
            }
        case .GetRestaurantDetail:
            placeId = "P08000001"
            if let placeId = placeId {
                placeService.getRestaurantDetail(placeId: placeId)
            }
        case .GetShopDetail:
            placeId = "P06000001"
            if let placeId = placeId {
                placeService.getShopDetail(placeId: placeId)
            }
        case .GetPlaceOtherDetail:
            placeId = "P01000001"
            if let placeId = placeId {
                placeService.getPlaceOtherDetail(placeId: placeId)
            }
        case .GetEventList: placeService.getEventList()
        case .GetEventDetail:
            eventId = "E0005812"
            if let eventId = eventId {
                placeService.getEventDetail(eventId: eventId)
            }
       
        case .GetRecommendedRouteList: placeService.getRecommendedRouteList()
        case .GetRecommendedRouteDetail:
            routeId = "R000000070"
            if let routeId = routeId {
                placeService.getRecommendedRouteDetail(routeId: routeId)
            }
            
        case .GetSHASearch: placeService.getSHASearch()
        case .GetSHADetail:
            placeId = "P02000147"
            if let placeId = placeId {
                placeService.getSHADetail(placeId: placeId)
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
    
    func toggleMenuIcon() {
        withAnimation(.easeInOut) {
            isShowCategotyMenu = !isShowCategotyMenu
        }
    }
}
 
