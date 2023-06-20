//
//  SinkViewModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-05-22.
//

import Foundation
import Combine
import SwiftUI

class SinkViewModel {
    var language = "TH"
    var subscription: AnyCancellable?
    
    init() {
        doSink(searchType: .ALL)
    }
    
    func doSink(searchType: PlaceSearchType) {
        var isLoop: Bool = true
        var resultItems: [PlaceSearchItem] = []
        var pagenumber = 1
        
        while isLoop {
            var parameters: [String:String] = [:]
            let apiRequest = APIStats.GetPlaceSearch.path
            
            pagenumber += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                print(" ** page : \(pagenumber) ")
                parameters["categorycodes"] = searchType.rawValue
                parameters["pagenumber"] = String(pagenumber)
                self.subscription = NetworkingManager.download(apiRequest: apiRequest, language: self.language, parameters: parameters)
                    .decode(type: PlaceSearchModel.self, decoder: JSONDecoder())
                // .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (result) in
                        resultItems = result.result
                        print(" page : \(pagenumber) size : \(resultItems.count)")

                        if resultItems.count == 0 {
                            self?.subscription?.cancel()
                        }

                    })
            }
                            
            if pagenumber == 3 {
                isLoop.toggle()
            }
            
//            DispatchQueue.global().async {
//                parameters["categorycodes"] = searchType.rawValue
//                parameters["pagenumber"] = String(pagenumber)
//                self.subscription = NetworkingManager.download(apiRequest: apiRequest, language: self.language, parameters: parameters)
//                    .decode(type: PlaceSearchModel.self, decoder: JSONDecoder())
//                // .receive(on: DispatchQueue.main)
//                    .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (result) in
//                        resultItems = result.result
//                        print(" page : \(pagenumber) size : \(resultItems.count)")
//
//                        if resultItems.count == 0 {
//                            self?.subscription?.cancel()
//                        }
//
//                    })
//                print(" page : \(pagenumber) size : \(resultItems.count)")
//                DispatchQueue.main.async {
//                    pagenumber += 1
//
//                    if pagenumber == 3 {
//                        isLoop.toggle()
//                    }
//                }
                
//            }
            
        }
    }
  
}
