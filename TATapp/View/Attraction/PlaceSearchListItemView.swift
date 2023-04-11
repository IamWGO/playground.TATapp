//
//  PlaceSearchListItemView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-11.
//

import SwiftUI

struct PlaceSearchListItemView: View {
    @EnvironmentObject var mainVM: MainViewModel
    @ObservedObject var vm: PlaceViewModel = PlaceViewModel()
     
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
         
            IconWithRoundBackgroundActionView(systemName: "map",
                                              backgroundColor: mainVM.getColorBySearchTypeCateogry(placeTypeString: placeItem.categoryCode)) {
                mainVM.getPlaceDetail(placeSearchItem: placeItem)
                vm.toggleMapIcon()
            }
            .background(
                Color.white.clipShape(Circle())
            )
            
            IconWithRoundBackgroundActionView(systemName: "magnifyingglass",
                                              backgroundColor: mainVM.getColorBySearchTypeCateogry(placeTypeString: placeItem.categoryCode)) {
                mainVM.getPlaceDetail(placeSearchItem: placeItem)
                vm.toggleDetailIcon()
            }
            .background(
                Color.white.clipShape(Circle())
            )
        }
    }
    
 
}
