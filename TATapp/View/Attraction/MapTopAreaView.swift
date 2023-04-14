//
//  MapTopAreaView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-11.
//

import SwiftUI

struct MapTopAreaView: View {
    @EnvironmentObject var mainVM: MainViewModel
    @EnvironmentObject var vm: PlaceViewModel
    @State var placeItem: PlaceItemModel
    
    var body: some View {
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
                Text(placeItem.getDistrictAndProvince())
                    .modifier(TextModifier(fontStyle: .caption))
                 
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
        }
        .padding()
        .background(.ultraThinMaterial)
    }
}
 
