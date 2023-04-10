//
//  MapSearchView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-08.
//

import SwiftUI
import MapKit

struct MapSearchView: View {
    @ObservedObject var mainVM: MainViewModel
    @ObservedObject var vm: LocationsViewModel
    
    @State var swipeDirection: SwipeDirection = .notAllow
    @State var isSwiftLeft: Bool = false
    
    init(mainVM: MainViewModel){
        self.mainVM = mainVM
        _vm = ObservedObject(wrappedValue: LocationsViewModel(mainVM: mainVM))
    }
   
    
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
        .sheet(item: $mainVM.selectedPlaceDetail) { _ in
            PlaceDetailView()
        }
        
    }
}

extension MapSearchView {
    
    private var header: some View {
        VStack(alignment: .leading) {
            if let mapPlaceItem = vm.mapPlaceItem {
                Button(action: vm.toggleLocationsList) {
                    HStack(spacing: 10){
                        Image(systemName: "arrow.down")
                            .modifier(TextModifier(fontStyle: .title3))
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
                        
                        Text(mapPlaceItem.placeName)
                            .modifier(TextModifier(fontStyle: .title3, alignment: .leading))
                            .frame(height: 55)
                            .animation(.none, value: vm.mapPlaceItem)
                            
                       Spacer()
                    }
                    
                }
            }
            
            
            if vm.showLocationsList {
                LocationsListView()
                .environmentObject(vm)
                .environmentObject(mainVM)
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
                LocationMapAnnotationView()
                    .scaleEffect(vm.mapPlaceItem == placeItem ? 1 : 0.7)
                    .shadow(radius: 10)
                    .background(
                        Circle()
                            .fill(vm.mapPlaceItem == placeItem ? Color.red : Color.clear )
                            .frame(width: 20)
                            .shadow(radius: 10)
                            .offset(y: 5)
                    )
                    .onTapGesture {
                        vm.showNextLocation(placeItem: placeItem)
                    }
            }
        })
    }
    
    private var locationsPreviewStack: some View {
        ZStack {
            if let placeItems = vm.placeItems {
                ForEach(placeItems) { placeItem in
                    if vm.mapPlaceItem == placeItem {
                        LocationPreviewView(placeItem: placeItem)
                            .environmentObject(vm)
                            .shadow(color: Color.black.opacity(0.3), radius: 20)
                            .padding()
                            .frame(maxWidth: maxWidthForIpad)
                            .frame(maxWidth: .infinity)
                        /*
                            .transition(.asymmetric(
                                insertion: .move(edge: isSwiftLeft ? .trailing : .leading),
                                removal: .move(edge: isSwiftLeft ? .leading : .trailing)))*/
                            .transition(.asymmetric(
                                insertion: .move(edge: .leading),
                                removal: .move(edge: .trailing)))
                            .modifier(SwipeGestureModifier( swipeDirection: $swipeDirection ))
                            .onChange(of: swipeDirection) { direction in
                               
                                if  direction == SwipeDirection.left  {
                                    isSwiftLeft = true
                                    vm.nextButtonPressed()
                                }
                                if  direction == SwipeDirection.right  {
                                    isSwiftLeft = false
                                    vm.PreviousButtonPressed()
                                }
                                swipeDirection = .notAllow
                            }
                           
                    }
                }
            } else {
                LoadingView()
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

