//
//  PlaceListView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-09.
//

import SwiftUI

struct PlaceListView: View {
    @EnvironmentObject var mainVM: MainViewModel
    @ObservedObject var vm: PlaceViewModel = PlaceViewModel()
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: isIpad ? 2 : 1)
    
    // MARK: - Body View
    var body: some View {
        ZStack {
            if let placeSearchItems =  mainVM.placeSearchItems {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns,spacing: 30){
                        ForEach(placeSearchItems){ placeSearchItem in
                            Button {
                                mainVM.getPlaceDetail(placeSearchItem: placeSearchItem)
                            } label: {
                                getPlaceItemUI(placeSearchItem: placeSearchItem)
                            }
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
            } else {
                LoadingView()
            }
            // Main Menu
            MainMenuView(isShowBackButton: true)
        }
        .onAppear {
            mainVM.selectedplaceId = nil
        }
        .sheet(item: $mainVM.selectedPlaceDetail) { _ in
            PlaceDetailView()
        }
        .modifier(HiddenNavigationBarModifier())
        .ignoresSafeArea()
    }
    
    
    private func getPlaceItemUI(placeSearchItem: PlaceSearchItem) -> some View {
        
        return ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            
            HStack(alignment: .top) {
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(placeSearchItem.placeName)
                        .modifier(TextModifier(fontStyle: .body, fontWeight: .bold))
                    
                    Text(mainVM.getDistrictAndProvince(location: placeSearchItem.location))
                        .modifier(TextModifier(fontStyle: .caption))
                    
                    /*HStack (spacing: 10){
                        Spacer()
                        VStackButtonActionView(systemName: .constant("magnifyingglass"),
                                               textButton: .constant(nil),
                                               foregroundColor: .constant(vm.isLiked ? Color.theme.active : Color.theme.inactive),
                                               isDisable: $vm.isLiked) {
                            vm.saveLiked()
                        }
                         
                        VStackButtonActionView(systemName: .constant("map"),
                                               textButton: .constant(nil),
                                               foregroundColor: .constant(vm.isShowMapSheet ? Color.theme.active : Color.theme.inactive),
                                               isDisable: .constant(!placeSearchItem.isHasLocation())) {
                            
                            vm.toggleMapIcon()
                        }
                    }*/
                    Spacer()
                }
                .frame(minHeight: 70)
                .padding(.leading, 60)
               
                Spacer()
               
            }
            .padding([.trailing, .top], 8)
            .padding(.leading)
            .padding()
            // image name same as color name....
            .background(Color.theme.background)
            .cornerRadius(20)
           
            .modifier(ShadowModifier())
            
           
                PlaceImageView(imageName: placeSearchItem.thumbnailUrl)
                    .frame(width: 80)
                    .clipShape(Circle())
                    .offset(x: -10, y: -30)
                
                
           
            
            
            
           
            
        }
    }
    
}

