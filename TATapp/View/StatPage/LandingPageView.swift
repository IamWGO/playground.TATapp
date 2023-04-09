//
//  LandingPageView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-05.
//

import SwiftUI

struct LandingPageView: View {
    @EnvironmentObject var mainVM: MainViewModel
    @EnvironmentObject var localVM: LocalizedViewModel
    @ObservedObject var vm: LandingPageViewModel
    
    @State var swipeDirection: SwipeDirection = .notAllow
    @State var isAllowLeftSwipe: Bool = true
    @State var isAllowRightSwipe: Bool = true
    
    init(mainVM: MainViewModel){
        _vm = ObservedObject(wrappedValue: LandingPageViewModel(mainVM: mainVM))
    }
    
    // MARK: - Body View
    var body: some View {
        ZStack {
            MainMenuView()
            VStack{
                Text("Landing Page View")
                    .modifier(TextModifier(fontStyle: .header))
            }
        }
        .background(BackgroundImageView())
        .ignoresSafeArea()
        .modifier(SwipeToGetMainMenuModifier(isShowCategotyMenu: $mainVM.isShowCategotyMenu))
    }
    
}
