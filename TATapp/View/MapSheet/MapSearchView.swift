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
    @EnvironmentObject private var vm: LocationsViewModel
    let maxWidthForIpad: CGFloat = 700
    
    var body: some View {
        ZStack {
            
            if let _ = mainVM.placeNearByItems {
                mapLayer
                    .ignoresSafeArea()
            }
            
            VStack(spacing: 0) {
                header
                    .padding()
                    .frame(maxWidth: maxWidthForIpad)
                
                Spacer()
                locationsPreviewStack
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in
            //LocationDetailView(location: location)
            Text(">> LocationDetailView")
        }
    }
}

extension MapSearchView {
    
    private var header: some View {
        VStack {
            if let mapPlaceItem = vm.mapPlaceItem {
                Button(action: vm.toggleLocationsList) {
                    Text(mapPlaceItem.placeName)
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .animation(.none, value: vm.mapPlaceItem)
                        .overlay(alignment: .leading) {
                            Image(systemName: "arrow.down")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding()
                                .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
                        }
                }
            }
            
            
            if vm.showLocationsList {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: mainVM.placeNearByItems ?? [],
            annotationContent: { placeItem in
            MapAnnotation(coordinate: placeItem.getCoordinate()) {
                LocationMapAnnotationView(placeName: placeItem.placeName)
                    .scaleEffect(vm.mapPlaceItem == placeItem ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(placeItem: placeItem)
                    }
            }
        })
    }
    
    private var locationsPreviewStack: some View {
        ZStack {
            if let placeItems = vm.placeItems{
                ForEach(placeItems) { placeItem in
                    if vm.mapPlaceItem == placeItem {
                        LocationPreviewView(placeItem: placeItem)
                            .shadow(color: Color.black.opacity(0.3), radius: 20)
                            .padding()
                            .frame(maxWidth: maxWidthForIpad)
                            .frame(maxWidth: .infinity)
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing),
                                removal: .move(edge: .leading)))
                    }
                }
            } else {
                EmptyView()
            }
            
        }
    }
    
}

/*
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
}*/

