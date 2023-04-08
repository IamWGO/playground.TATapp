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
    @ObservedObject var vm: LocationsViewModel
    @State var placeItem: AttractionDetail
    @State var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    init(mainVM: MainViewModel,placeItem: AttractionDetail){
        self.mainVM = mainVM
        self.placeItem = placeItem
        _vm = ObservedObject(wrappedValue: LocationsViewModel(mainVM: mainVM))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            
           if let placeNearByItems = mainVM.placeNearByItems {
                
                Map(coordinateRegion: $mapRegion,
                             annotationItems: placeNearByItems,
                             annotationContent: { placeItem in
                             MapAnnotation(coordinate: placeItem.getCoordinate()) {
                                 LocationMapAnnotationView(placeName: placeItem.placeName)
                                     .scaleEffect(vm.mapLocation == placeItem ? 1 : 0.7)
                                     .shadow(radius: 10)
                                     .onTapGesture {
                                         vm.showNextLocation(location: placeItem)
                                     }
                             }
                         })
            } else {
                Map(coordinateRegion: $mapRegion,
                    annotationItems:  [placeItem],
                    annotationContent: { placeItem in
                    MapAnnotation(coordinate: placeItem.getCoordinate()) {
                        LocationMapAnnotationView(placeName: placeItem.placeName)
                        .scaleEffect(0.7)
                            .shadow(radius: 10)
                            .onTapGesture {
                                //  vm.showNextLocation(location: location)
                            }
                    }
                })
            }
            
           
            /*Map(coordinateRegion: $mapRegion,
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
            })*/
            
           
            topAreaSection
        }
        .onAppear {
            if let latitude = placeItem.latitude, let longitude = placeItem.longitude {
                mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
            }
        }
        .ignoresSafeArea(.all)
        
    }
    
    private var topAreaSection: some View {
        VStack{
            HStack{
                TopAreaIconActionView(systemName: "chevron.backward", action: {
                    // do something
                })
                
                Text(placeItem.placeName)
                    .modifier(TextModifier(fontStyle: .title3))
                Spacer()
            }
            
            HStack(spacing: 8){
                
                Image(systemName: "mappin.and.ellipse")
                    .font(.caption)
                Text(mainVM.getDistrictAndProvince(location: placeItem.location))
                    .modifier(TextModifier(fontStyle: .caption))
               
                
                Spacer()
                
                Image(systemName: "phone")
                    .modifier(TextModifier(fontStyle: .caption))
                
                Text(placeItem.contact.phones?[0] ?? "")
                    .font(.caption)
                    .modifier(TextModifier(fontStyle: .caption))
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
        }
        .padding()
        .background(.ultraThinMaterial)
        
    }
}
