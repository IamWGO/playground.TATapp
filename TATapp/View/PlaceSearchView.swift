//
//  PlaceSearchView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-05.
//

import SwiftUI

struct PlaceSearchView: View {
    @EnvironmentObject var mainVM: MainViewModel
    
    var body: some View {
        /*ScrollView {
            VStack {
                if let items = mainVM.placeSearchItems {
                    ForEach(items.result) { item in
                        Text(item.placeName)
                    }
                }
            }
            .padding()
        }*/
        
        PlaceDetailView()
        
    }
}

struct PlaceSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceSearchView()
    }
}
