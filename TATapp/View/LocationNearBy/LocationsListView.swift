//
//  LocationsListView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-08.
//
import SwiftUI


struct LocationsListView: View {
    @EnvironmentObject var mainVM: MainViewModel
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        if let placeItems = vm.placeItems {
            List {
                ForEach(placeItems) { placeItem in
                    Button {
                        vm.showNextLocation(placeItem: placeItem)
                    } label: {
                        listRowView(placeItem: placeItem)
                    }
                    .padding(.vertical, 4)
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(PlainListStyle())
        } else {
            EmptyView()
        }
        
    }
}


extension LocationsListView {
    
    private func listRowView(placeItem: PlaceSearchItem) -> some View {
        HStack {
            PlaceImageView(imageName: placeItem.thumbnailUrl)
                .frame(width: 45, height: 45)
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(placeItem.placeName)
                    .font(.headline)
                Text(placeItem.getShaTypeDescription())
                    .font(.caption)
                    .padding(.bottom, 8)
                Text(placeItem.getDistrictAndProvince())
                    .font(.subheadline)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
}

