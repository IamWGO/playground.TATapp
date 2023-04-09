//
//  LandingPageViewModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-06.
//

import SwiftUI
import Combine

class LandingPageViewModel: ObservableObject {
    
    @Published var mainVM: MainViewModel
    //@Published var isShowCategotyMenu: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(mainVM: MainViewModel) {
        self.mainVM = mainVM
        onChangePublisher()
    }
    
    func onChangePublisher(){
       /* $isShowCategotyMenu.sink{ _ in
            withAnimation(.easeInOut) {
               
            }
        }
        .store(in: &cancellables)*/
    }
    
    func toggleMenuIcon() {
      /*  withAnimation(.easeInOut) {
            isShowCategotyMenu = !isShowCategotyMenu
        }*/
    }
}
