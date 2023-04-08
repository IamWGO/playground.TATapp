//
//  LocationsViewModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-07.
//

import Foundation
import MapKit
import SwiftUI


class LocationsViewModel: ObservableObject {
    @Published var mainVM: MainViewModel
    // All loaded locations
    @Published var locations: [PlaceItem]
    
    // Current location on map
    @Published var mapLocation: PlaceItem {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    // Current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // Show list of locations
    @Published var showLocationsList: Bool = false
    
    // Show location detail via sheet
    @Published var sheetLocation: PlaceItem? = nil
    
    init(mainVM: MainViewModel) {
        self.mainVM = mainVM
        let locations = mainVM.placeNearByItems ?? []
        self.locations = locations
        self.mapLocation = locations.first!
    }
    
    private func updateMapRegion(location: PlaceItem) {
       /* withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.getCoordinate(),
                span: mapSpan)
        }*/
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
//            showLocationsList = !showLocationsList
            showLocationsList.toggle()
        }
    }
    
    func showNextLocation(location: PlaceItem) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    func nextButtonPressed() {
        // Get the current index
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
            print("Could not find current index in locations array! Should never happen.")
            return
        }
        
        // Check if the currentIndex is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // Next index is NOT valid
            // Restart from 0
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        // Next index IS valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
    
}
