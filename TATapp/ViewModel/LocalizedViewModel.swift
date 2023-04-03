//
//  LocalizedViewModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-05.
//

import Foundation
import Combine


class LocalizedViewModel: ObservableObject {
    let localizedService: LocalizedService
    
    @Published var currentScreen: ScreenState = ScreenState.Landing
    @Published var landingString: [String : String] = [:]
    @Published var homeString: [String: String] = [:]
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        localizedService = LocalizedService()
        currentScreen = ScreenState.Landing
        getLocalText()
    }
    
    func getLocalText(){
        $currentScreen.sink{ [weak self] (currentScreen) in
            self?.getStringsByUIScreen(currentScreen: currentScreen)
        }
        .store(in: &cancellables)
        
        localizedService.$landingString
            .sink{ result in
                self.landingString = result
            }
            .store(in: &cancellables)
        
        localizedService.$homeString
            .sink{ result in
                self.homeString = result
            }
            .store(in: &cancellables)
    }
    
    func getStringsByUIScreen(currentScreen: ScreenState) {
        switch (currentScreen) {
        case .Landing: localizedService.getLandingString()
        case .Home: break
        }
    }
    
}
