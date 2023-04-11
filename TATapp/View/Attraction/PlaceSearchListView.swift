//
//  PlaceListView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-09.
//

import SwiftUI

struct PlaceSearchListView: View {
    @EnvironmentObject var mainVM: MainViewModel
    @ObservedObject var vm: PlaceViewModel = PlaceViewModel()
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: isIpad ? 2 : 1)
    
    // MARK: - Body View
    var body: some View {
        ZStack {
            if let placeSearchItems =  mainVM.placeSearchItems {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns,spacing: 5){
                        ForEach(placeSearchItems){ placeSearchItem in
                            PlaceSearchListItemView(placeItem: placeSearchItem)
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
        .sheet(item: $mainVM.selectedPlaceDetail) { placeItem in
            PlaceDetailView()
           // MapSheetView(mainVM: mainVM, placeItem: placeItem, isShowDetailIcon: true)
        }
        .modifier(HiddenNavigationBarModifier())
        .ignoresSafeArea()
    }
    
}

