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
            VStack(spacing: 0) {
                HStack{
                    logo
                    Spacer()
                    animateButton
                }
                .padding(.horizontal)
                
                ZStack(alignment: .top) {
                    
                    VStack {
                        header
                        ScrollView {
                            GridView()
                        }
                    }.padding(.top)
                    
                    if vm.isShowCategotyMenu {
                        categoryList
                    }
                }
            }
            .padding(.top, mainVM.getTopSafeAreaSize())
        }
      
        .modifier(SwipeGestureModifier(
            swipeDirection: $swipeDirection,
            isAllowLeftSwipe: .constant(false),
            isAllowRightSwipe: .constant(false),
            isAllowUpSwipe: .constant(true),
            isAllowDownSwipe: .constant(true)
        ))
        .onChange(of: swipeDirection) { direction in
            if  direction == SwipeDirection.down  {
                vm.toggleMenuIcon()
            }
            swipeDirection = .notAllow
        }
        .background(backgroundImage)
        .ignoresSafeArea()
    }
    
    // MARK: - Section View
    private var logo: some View {
        Image("logo")
            .resizable()
            .scaledToFit()
            .frame(width: 55)
            .clipShape(Circle())
    }
    
    private var backgroundImage: some View {
        Image("landing-background")
            .resizable()
            .scaledToFill()
            .overlay {
                Color.white.opacity(0.6)
            }
    }
    
    private var header : some View {
        VStack(alignment: .leading) {
            Text(localVM.landingString["subHeader"] ?? "sub-header")
                .modifier(TextModifier(fontStyle: .title, fontWeight: .bold))
            Text(localVM.landingString["header"] ?? "header")
                .modifier(TextModifier(fontStyle: .large, fontWeight: .regular))
        }
    }
     
    
    private var animateButton: some View {
        VStack {
            Button {
                vm.toggleMenuIcon()
            } label: {
                Image(systemName: "text.justify")
                    .font(.headline)
                    .foregroundColor(Color.theme.primary)
                    .padding()
                    .rotationEffect(Angle(degrees: vm.isShowCategotyMenu ? 180 : 0))
            }
        }
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
    private var categoryList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            HStack{
                Spacer()
                VStack(alignment: .trailing) {
                    ForEach(categoryItem) { item in
                        
                        Button {
                            
                        } label: {
                            HStack(spacing: 8){
                                Image(systemName: item.systemName)
                                    .modifier(TextModifier(fontStyle: .title, foregroundColor: item.foregroundColor))
                                Text(item.name)
                                    .fontWeight(.semibold)
                                    .modifier(TextModifier(fontStyle: .body, foregroundColor: item.foregroundColor))
                                Spacer()
                            }
                        }
                        .padding()
                        .frame(width:  kScreen.width * (isIpad ? 0.2 : 0.5))
                        

                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.ultraThinMaterial)
                       // .offset(y: 30)
                )
            }
            .padding(.horizontal)
        }
    }
}
