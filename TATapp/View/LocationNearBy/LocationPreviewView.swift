//
//  LocationPreviewView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-08.
//


import SwiftUI

struct LocationPreviewView: View {
    //@Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mainVM: MainViewModel
    @EnvironmentObject private var locationVM: LocationsViewModel
    @EnvironmentObject private var vm: PlaceViewModel
    
    @State var isShowDetailSheet: Bool = false
    
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
        .sheet(isPresented: $isShowDetailSheet, content: {
            PlaceDetailSheetView()
        })
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
            
            Text(placeItem.getDistrictAndProvince())
                .modifier(TextModifier(fontStyle: .caption))
        }
        
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        Button {
            mainVM.getPlaceDetail(placeSearchItem: placeItem)
            isShowDetailSheet.toggle()
        } label: {
            Text("Learn more")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
        .accentColor(Color.theme.button)
        
    }
    
    private var nextButton: some View {
        Button {
            locationVM.nextButtonPressed()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
    
}
