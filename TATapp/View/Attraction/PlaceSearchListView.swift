//
//  PlaceListView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-09.
//

import SwiftUI

struct PlaceSearchListView: View {
    @EnvironmentObject var mainVM: MainViewModel
    @StateObject var vm: PlaceViewModel = PlaceViewModel()
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: isIpad ? 2 : 1)
    
    // MARK: - Body View
    var body: some View {
        ZStack {
            
            if let _ = mainVM.placeNearByItems {
                LocationNearByView(mainVM: mainVM)
                    .environmentObject(vm)
            } else {
                if let placeSearchItems =  mainVM.placeSearchItems {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns,spacing: 5){
                            ForEach(placeSearchItems){ placeSearchItem in
                                PlaceSearchListItemView(placeItem: placeSearchItem)
                                    .environmentObject(vm)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top,25)
                        
                    }
                    .padding(.top, mainVM.getTopSafeAreaSize() + 70)
                    .padding(.bottom, 25)
                    
                    if mainVM.isLoading {
                        LoadingView()
                    }
                    
                    // Main Menu
                    MainMenuView(isShowBackButton: true)
                }
            }
            
           
        }
        .onAppear {
            mainVM.selectedplaceId = nil
        }

        .sheet(item: $mainVM.selectedPlaceDetail) { placeItem in
            PlaceDetailView()
                .environmentObject(vm)
        }
        .modifier(HiddenNavigationBarModifier())
        .ignoresSafeArea()
    }
    
}

// MARK: - List View item

struct PlaceSearchListItemView: View {
    @EnvironmentObject var mainVM: MainViewModel
    @EnvironmentObject var vm: PlaceViewModel
    @State var shouldNavigate: Bool = false
    let placeItem: PlaceSearchItem
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack {
                HStack {
                    imageSection
                    Spacer()
                    learnMoreButton
                }
                titleSection
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                //.fill(.ultraThinMaterial)
                .fill(mainVM.getColorBySearchTypeCateogry(placeTypeString: placeItem.categoryCode).opacity(0.2))
                .offset(y: 65)
                //.shadow(radius: 10)
        )
        .cornerRadius(10)
    }
}


extension PlaceSearchListItemView {
    
    private var imageSection: some View {
        ZStack {
            PlaceImageView(imageName: placeItem.thumbnailUrl)
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
            Text(placeItem.placeName)
                .modifier(TextModifier(fontStyle: .title3))
            
            Text(mainVM.getDistrictAndProvince(location: placeItem.location))
                .modifier(TextModifier(fontStyle: .caption))
        }
        
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
 
        HStack{
         
            IconWithRoundBackgroundActionView(systemName: "mappin.and.ellipse",
                                              backgroundColor: mainVM.getColorBySearchTypeCateogry(placeTypeString: placeItem.categoryCode)) {
                mainVM.currentState = RequestStates.GetPlaceNearBy
                vm.toggleNearByIcon()
            }
            .background(
                Color.white.clipShape(Circle())
            )
            
            IconWithRoundBackgroundActionView(systemName: "magnifyingglass",
                                              backgroundColor: mainVM.getColorBySearchTypeCateogry(placeTypeString: placeItem.categoryCode)) {
                mainVM.getPlaceDetail(placeSearchItem: placeItem)
            }
            .background(
                Color.white.clipShape(Circle())
            )
        }
    }
    
 
}

