//
//  MainViewModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-03.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {

    private let placeSearchService: PlaceSearchService
    private var cancellables = Set<AnyCancellable>()
    
    @Published var placeSearchItems: PlaceSearchModel? = nil
    
    init() {
        self.placeSearchService = PlaceSearchService()
        self.getPlaceSearch()
    }
    
    
    func getPlaceSearch() {
        placeSearchService.$placeSearchItems
            .sink { [weak self] (returnedArrays) in
                self?.placeSearchItems = returnedArrays
            }
            .store(in: &cancellables)
    }
    
}
