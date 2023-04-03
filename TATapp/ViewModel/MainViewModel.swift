//
//  MainViewModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-03.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {

    let placeSearchService: PlaceSearchService
    
    @Published var placeSearchItems: PlaceSearchModel? = nil
    
    private var cancellables = Set<AnyCancellable>() 
    
    init() {
        self.placeSearchService = PlaceSearchService()
        self.getPlaceSearch()
    }
    
    
    func getPlaceSearch() {
        placeSearchService.$placeSearchItems
            .sink { [weak self] (returnedArrays) in
                self?.placeSearchItems = returnedArrays
                print(returnedArrays)
            }
            .store(in: &cancellables)
    }
    
}
