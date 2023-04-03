//
//  ContentView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-03.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var mainVM: MainViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                if let items = mainVM.placeSearchItems {
                    ForEach(items.result) { item in
                        Text(item.placeName)
                    }
                }
            }
            .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
