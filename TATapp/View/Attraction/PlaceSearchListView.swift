//
//  PlaceListView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-09.
//

import SwiftUI

struct PlaceSearchListView: View {
    @ObservedObject var mainVM: MainViewModel
    @StateObject var vm: PlaceViewModel = PlaceViewModel()
    @StateObject var locationVM: LocationsViewModel
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: isIpad ? 2 : 1)
    
    init(mainVM: MainViewModel){
        self.mainVM = mainVM
        _locationVM = StateObject(wrappedValue: LocationsViewModel(mainVM: mainVM))
    }
    
    // MARK: - Body View
    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let placeSearchItems =  mainVM.placeSearchItems {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns,spacing: 5){
                        ForEach(placeSearchItems){ placeSearchItem in
                            PlaceSearchListItemView(placeSearchItem: placeSearchItem)
                                .environmentObject(locationVM)
                                .environmentObject(mainVM)
                                .environmentObject(vm)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top,25)
                    
                }
                .padding(.bottom, 25)
                .padding(.top, mainVM.getTopSafeAreaSize() + 70)
                
                if mainVM.isLoading {
                    LoadingView()
                }
                
                // Main Menu
                MainMenuView(isShowBackButton: true)
            }
            
            
        }
        
        .onAppear{
            mainVM.selectedPlaceDetail = nil
        }
        .modifier(HiddenNavigationBarModifier())
        .ignoresSafeArea()
    }
    
}

// MARK: - List View item

struct PlaceSearchListItemView: View {
    @EnvironmentObject var mainVM: MainViewModel
    @EnvironmentObject var vm: PlaceViewModel
    @EnvironmentObject var locationVM: LocationsViewModel
     
    @State private var selection: Int? = nil
    let placeSearchItem: PlaceSearchItem
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            
            VStack {
                HStack {
                    Button {
                        mainVM.getPlaceDetail(placeSearchItem: placeSearchItem)
                        selection = 2
                    } label: {
                        imageSection
                    }
                    Spacer()
                    learnMoreButton
                }
                titleSection
            }
            
            NavigationLink(destination:
                            LocationNearByView()
                                .environmentObject(locationVM)
                                .environmentObject(mainVM)
                                .environmentObject(vm),
                           tag: 1, selection: $selection) {  EmptyView() }
            
            NavigationLink(destination: PlaceDetailView()
                                        .environmentObject(locationVM)
                                        .environmentObject(mainVM)
                                        .environmentObject(vm),
                           tag: 2, selection: $selection) {  EmptyView() }
        
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                //.fill(.ultraThinMaterial)
                .fill(placeSearchItem.getPlaceTypeColor().opacity(0.2))
                .offset(y: 65)
                //.shadow(radius: 10)
        )
        .cornerRadius(10)
    }
}


extension PlaceSearchListItemView {
    
    private var imageSection: some View {
        ZStack {
            PlaceImageView(imageName: placeSearchItem.thumbnailUrl)
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
        .modifier(ShadowModifier())
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(placeSearchItem.placeName)
                .modifier(TextModifier(fontStyle: .title3))
            
            Text(placeSearchItem.getDistrictAndProvince())
                .modifier(TextModifier(fontStyle: .caption))
        }
        
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
 
        HStack{
         
            IconWithRoundBackgroundActionView(systemName: "mappin.and.ellipse",
                                              backgroundColor: placeSearchItem.getPlaceTypeColor()) {
                mainVM.currentState = RequestStates.GetPlaceNearBy
                selection = 1
            }
            .background(
                Color.white.clipShape(Circle())
            )
            
            IconWithRoundBackgroundActionView(systemName: "magnifyingglass",
                                              backgroundColor: placeSearchItem.getPlaceTypeColor()) {
                mainVM.getPlaceDetail(placeSearchItem: placeSearchItem)
                selection = 2
            }
            .background(
                Color.white.clipShape(Circle())
            )
        }
    }
 
}

