//
//  LocationPreviewView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-08.
//


import SwiftUI

struct LocationPreviewView: View {
    @EnvironmentObject var mainVM: MainViewModel
    @EnvironmentObject private var vm: LocationsViewModel
    
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
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .cornerRadius(10)
    }
}


extension LocationPreviewView {
    
    private var imageSection: some View {
        ZStack {
            PlaceImageView(imageName: placeItem.thumbnailUrl)
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
             
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
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
        Button {
            mainVM.getPlaceDetail(placeSearchItem: placeItem)
        } label: {
            Text("Learn more")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button {
            vm.nextButtonPressed()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
    
}
