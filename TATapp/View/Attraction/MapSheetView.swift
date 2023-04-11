//
//  MapView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-07.
//

import SwiftUI
import MapKit

struct MapSheetView: View {
    @ObservedObject var mainVM: MainViewModel
    @ObservedObject var locationVM: LocationsViewModel
    @EnvironmentObject var vm: PlaceViewModel
    
    @State var placeItem: PlaceItemModel
    @State var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    init(mainVM: MainViewModel,placeItem: PlaceItemModel){
        self.mainVM = mainVM
        self.placeItem = placeItem
        _locationVM = ObservedObject(wrappedValue: LocationsViewModel(mainVM: mainVM))
    }
    
    var body: some View {
        
        if vm.isShowNearBySheet {
            //LocationNearByView(mainVM: mainVM)
            Button {
                vm.toggleNearByIcon()
            } label: {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .modifier(TextModifier(fontStyle: .caption))
                    
                    Text("nearBy")
                        .font(.caption)
                        .modifier(TextModifier(fontStyle: .caption))
                }
                .padding(8)
                .background(Color.theme.button.opacity(0.2))
                .cornerRadius(5)
            }
        } else {
            mapLocation
        }
    }
    
    private var mapLocation:some View {
        ZStack(alignment: .top) {
           if let placeNearByItems = mainVM.placeNearByItems {
               if placeNearByItems.count > 0 {
                   Map(coordinateRegion: $mapRegion,
                                annotationItems: placeNearByItems,
                                annotationContent: { placeItem in
                                MapAnnotation(coordinate: placeItem.getCoordinate()) {
                                    LocationMapAnnotationView()
                                        .scaleEffect(locationVM.mapPlaceItem == placeItem ? 1 : 0.7)
                                        .shadow(radius: 10)
                                        .onTapGesture {
                                            locationVM.showNextLocation(placeItem: placeItem)
                                        }
                                }
                            })
               } else {
                   singlePinLocation
               }
            } else {
                singlePinLocation
            }
           
            topAreaSection
        }
        
        .onAppear {
            vm.isShowNearBySheet = false
            
            if let latitude = placeItem.latitude, let longitude = placeItem.longitude {
                mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                                               span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
            }
        }
        .ignoresSafeArea(.all)
    }
    
    private var singlePinLocation: some View {
        Map(coordinateRegion: $mapRegion,
            annotationItems:  [placeItem],
            annotationContent: { placeItem in
            MapAnnotation(coordinate: placeItem.getCoordinate()) {
                LocationMapAnnotationView()
                .scaleEffect(0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        //  vm.showNextLocation(location: location)
                    }
            }
        })
    }
    
    private var topAreaSection: some View {
        VStack{
            HStack{
                /*TopAreaIconActionView(systemName: "chevron.backward", action: {
                    presentationMode.wrappedValue.dismiss()
                })*/
                
                Text(placeItem.placeName)
                    .modifier(TextModifier(fontStyle: .title3))
                Spacer()
            }
            
            HStack(spacing: 8){
                
                Image(systemName: "pin")
                    .font(.caption)
                Text(mainVM.getDistrictAndProvince(location: placeItem.location))
                    .modifier(TextModifier(fontStyle: .caption))
               
                
                Spacer()
                Button {
                    vm.toggleNearByIcon()
                } label: {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .modifier(TextModifier(fontStyle: .caption))
                        
                        Text("nearBy")
                            .font(.caption)
                            .modifier(TextModifier(fontStyle: .caption))
                    }
                    .padding(8)
                    .background(Color.theme.button.opacity(0.2))
                    .cornerRadius(5)
                }
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
        }
        .padding()
        .background(.ultraThinMaterial)
        
    }
}


/*
 .sheet(item: $mainVM.placeNearByItems) { _ in
     MapSearchView(mainVM: mainVM)
 }
 */
