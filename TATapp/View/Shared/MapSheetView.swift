//
//  MapView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-07.
//

import SwiftUI
import MapKit

struct MapSheetView: View {
    @EnvironmentObject var mainVM: MainViewModel
    @State var placeItem = DummyAttractionDetail
    @State private var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 18.805148, longitude: 98.901021), span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
    
    var body: some View {
        ZStack(alignment: .top) {
            
            
            Map(coordinateRegion: $mapRegion)
            
            VStack{
                Spacer()
                Text("Map View")
                    .font(.headline)
                Spacer()
            }
            
            topAreaSection
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

struct MapSheetView_Previews: PreviewProvider {
    static var previews: some View {
        MapSheetView()
    }
}
