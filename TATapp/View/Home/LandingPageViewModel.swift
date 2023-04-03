//
//  LandingPageViewModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-06.
//

import SwiftUI

class LandingPageViewModel: ObservableObject {
    
    @Published var mainVM: MainViewModel
    @Published var isShowCategotyMenu: Bool = false
    
    init(mainVM: MainViewModel) {
        self.mainVM = mainVM
    }
    
    func toggleMenuIcon() {
        withAnimation(.easeInOut) {
            isShowCategotyMenu = !isShowCategotyMenu
        }
    }
}
