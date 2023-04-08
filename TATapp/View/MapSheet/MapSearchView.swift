//
//  MapSearchView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-08.
//

import SwiftUI
import MapKit

struct MapSearchView: View {
    @EnvironmentObject var mainVM: MainViewModel
    
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

struct MapSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            LocationMapAnnotationView(placeName: "Place name")
        }
    }
}

