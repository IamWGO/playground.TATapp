//
//  PlaceDetailSheetView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-06.
//

import SwiftUI
import MapKit

struct PlaceDetailSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var scheme
    
    @EnvironmentObject var mainVM: MainViewModel
    @EnvironmentObject var vm: PlaceViewModel
    @State private var isShowMap: Bool = false
    @State private var shouldNavigate = false
    
    var body: some View {
        ZStack(alignment: .top) {
        if let placeItem = mainVM.selectedPlaceDetail {
            
                if mainVM.isLoading {
                    LoadingView()
                } else {
                    PlaceDescriptionView(placeItem: placeItem, offsetHeight: 350)
                    .overlay(
                        // Only Safe Area....
                        (scheme == .dark ? Color.black : Color.white)
                            .frame(height: mainVM.getTopSafeAreaSize())
                            .ignoresSafeArea(.all, edges: .top)
                            .opacity(vm.offset > 350 ? 1 : 0)
                        ,alignment: .top
                    )
                }
            
        } else {
            LoadingView()
        }
        }
        .ignoresSafeArea()
    }
}
