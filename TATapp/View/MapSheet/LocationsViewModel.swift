//
//  LocationsViewModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-07.
//

import Foundation
import MapKit
import SwiftUI
import Combine

class LocationsViewModel: ObservableObject {
    @Published var mainVM: MainViewModel
    // All loaded locations
    @Published var placeItems: [PlaceItem]? = nil
    
    // Current location on map
    @Published var mapPlaceItem: PlaceItem? {
        didSet {
            if let mapPlaceItem = mapPlaceItem {
                updateMapRegion(placeItem: mapPlaceItem)
            }
        }
    }
    
    // Current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // Show list of locations
    @Published var showLocationsList: Bool = false
    // Show location detail via sheet
    
    @Published var sheetLocation: PlaceItem? = nil
    private var cancellables = Set<AnyCancellable>()
    
    init(mainVM: MainViewModel) {
        self.mainVM = mainVM
        self.setPinLocations()
    }
    
    func setPinLocations(){
        
        mainVM.$placeNearByItems
            .sink{ (placeNearByItems) in
                if let placeItems = placeNearByItems {
                    if placeItems.count > 0 {
                        self.placeItems = placeItems
                        self.mapPlaceItem = placeItems.first!
                    }
                }
            }
            .store(in: &cancellables)
        
        
    }
    
    private func updateMapRegion(placeItem: PlaceItem) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: placeItem.getCoordinate(),
                span: mapSpan)
        }
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList = !showLocationsList
            showLocationsList.toggle()
        }
    }
    
    func showNextLocation(placeItem: PlaceItem) {
        withAnimation(.easeInOut) {
            mapPlaceItem = placeItem
            showLocationsList = false
        }
    }
    
    func nextButtonPressed() {
        guard let placeItems = placeItems else { return }
        
        // Get the current index
        guard let currentIndex = placeItems.firstIndex(where: { $0 == mapPlaceItem }) else {
            print("Could not find current index in locations array! Should never happen.")
            return
        }
        
        // Check if the currentIndex is valid
        let nextIndex = currentIndex + 1
        guard placeItems.indices.contains(nextIndex) else {
            // Next index is NOT valid
            // Restart from 0
            guard let firstLocation = placeItems.first else { return }
            showNextLocation(placeItem: firstLocation)
            return
        }
        
        // Next index IS valid
        let nextLocation = placeItems[nextIndex]
        showNextLocation(placeItem: nextLocation)
    }
    
}
