//
//  MapSearchView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-08.
//

import SwiftUI
import MapKit

struct LocationNearByView: View {
    @EnvironmentObject var vm: PlaceViewModel
    
    @ObservedObject var mainVM: MainViewModel
    @ObservedObject var locationVM: LocationsViewModel
    
    @State var swipeDirection: SwipeDirection = .notAllow
    @State var isSwiftLeft: Bool = false
    
    init(mainVM: MainViewModel){
        self.mainVM = mainVM
        _locationVM = ObservedObject(wrappedValue: LocationsViewModel(mainVM: mainVM))
    }
   
    let maxWidthForIpad: CGFloat = 700
    
    var body: some View {
        ZStack(alignment: .top) {
            if let _ = mainVM.placeNearByItems {
                mapLayer
                    .ignoresSafeArea()
            }
            
            VStack(spacing: 0) {
                if let placeItem = mainVM.selectedPlaceDetail {
                    MapTopAreaView(placeItem: placeItem)
                }
                
                nearBySearchItems
                    .padding(.trailing, 8)
                    .padding(.horizontal)
                    .frame(maxWidth: maxWidthForIpad)
                
                Spacer()
                locationsPreviewStack
            }
            .padding(.bottom, 25)
        }
        
//        ZStack {
//            if let _ = mainVM.placeNearByItems {
//                mapLayer
//                    .ignoresSafeArea()
//            }
//
//            VStack(spacing: 0) {
//
//                header
//                    .padding(.trailing, 8)
//                    .padding([.top, .leading, .bottom])
//                    .frame(maxWidth: maxWidthForIpad)
//
//                Spacer()
//                locationsPreviewStack
//            }
//            .padding(.top, mainVM.getTopSafeAreaSize())
//            .padding(.bottom, 25)
//        }
//        .sheet(item: $mainVM.selectedPlaceDetail) { _ in
//            PlaceDetailView()
//        }
    }
}

extension LocationNearByView {
    
    private var nearBySearchItems: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 0) {
                if let mapPlaceItem = locationVM.mapPlaceItem {
                    Button(action: locationVM.toggleLocationsList) {
                        HStack(spacing: 10){
                            Text(mapPlaceItem.placeName)
                                .modifier(TextModifier(fontStyle: .body, alignment: .leading))
                                .frame(height: 55)
                                .animation(.none, value: locationVM.mapPlaceItem)
                                
                            Spacer()
                           
                            Image(systemName: "arrow.down")
                                .modifier(TextModifier(fontStyle: .title3))
                                .foregroundColor(.primary)
                                .padding([.top,.bottom, .trailing])
                                .rotationEffect(Angle(degrees: locationVM.showLocationsList ? 180 : 0))
                        }.padding(.leading, 15)
                    }
                }
                if locationVM.showLocationsList {
                    LocationsListView()
                    .environmentObject(locationVM)
                    .environmentObject(mainVM)
                }
            }
            .background(.thickMaterial)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
            .offset(y: -10)
            
//            IconWithRoundBackgroundActionView(systemName: "chevron.backward", backgroundColor: Color.theme.button, action: {
//                mainVM.placeNearByItems = nil
//                vm.toggleNearByIcon()
//            })
//            .background(
//                Color.white.clipShape(Circle())
//            )
//            .offset(x: -8, y: 4)
        }
       
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: $locationVM.mapRegion,
            annotationItems: mainVM.placeNearByItems ?? [],
            annotationContent: { placeItem in
            MapAnnotation(coordinate: placeItem.getCoordinate()) {
                LocationMapAnnotationView()
                    .scaleEffect(locationVM.mapPlaceItem == placeItem ? 1 : 0.7)
                    .shadow(radius: 10)
                    .background(
                        Circle()
                            .fill(locationVM.mapPlaceItem == placeItem ? Color.red : Color.clear )
                            .frame(width: 20)
                            .shadow(radius: 10)
                            .offset(y: 5)
                    )
                    .onTapGesture {
                        locationVM.showNextLocation(placeItem: placeItem)
                    }
            }
        })
    }
    
    private var locationsPreviewStack: some View {
        ZStack {
            if let placeItems = locationVM.placeItems {
                ForEach(placeItems) { placeItem in
                    if locationVM.mapPlaceItem == placeItem {
                        LocationPreviewView(placeItem: placeItem)
                            .environmentObject(locationVM)
                            .shadow(color: Color.black.opacity(0.3), radius: 20)
                            .padding()
                            .frame(maxWidth: maxWidthForIpad)
                            .frame(maxWidth: .infinity)
                            .transition(.asymmetric(
                                insertion: .move(edge: isSwiftLeft ? .trailing : .leading),
                                removal: .move(edge: isSwiftLeft ? .leading : .trailing)))
                            .modifier(SwipeGestureModifier( swipeDirection: $swipeDirection ))
                            .onChange(of: swipeDirection) { direction in
                               
                                if  direction == SwipeDirection.left  {
                                    isSwiftLeft = true
                                    locationVM.nextButtonPressed()
                                }
                                if  direction == SwipeDirection.right  {
                                    isSwiftLeft = false
                                    locationVM.PreviousButtonPressed()
                                }
                                if  direction == SwipeDirection.down  {
                                    vm.toggleNearByIcon()
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
