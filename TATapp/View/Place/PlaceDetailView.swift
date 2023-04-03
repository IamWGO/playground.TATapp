//
//  PlaceDetailView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-03.
//

import SwiftUI

struct PlaceDetailView: View {
    @EnvironmentObject var mainVM: MainViewModel
    
    @State var placeItem: PlaceItem = DummyplaceItem
   
    // For Dark Mode Adoption....
    @Environment(\.colorScheme) var scheme
    var body: some View {
        Text("Hello")
    }
}



/*
 
 struct PlaceSearchCard: View {
     
     @State var isActive = false
     
     var body: some View {
         
         ZStack(alignment:.bottom) {
             Image("thumb1")
                 .resizable()
                 .aspectRatio(contentMode: .fill)
                 .edgesIgnoringSafeArea([.top])
             
              VStack(spacing: 18){
                 
                 // Video Playback Details And Buttons....
                 VStack(alignment: .leading, spacing: 8, content: {
                     Text("M1 MacBook Unboxing And First Impressions")
                         .font(.body)
                     
                     Text("1.2M Views")
                         .font(.caption)
                         .fontWeight(.bold)
                         .foregroundColor(.gray)
                 })
                 .padding(.top)
                 // Buttons....
                 
                 HStack{
                     IconActionView(systemName: "hand.thumbsup", text: "123K", isActive: $isActive) { }
                     
                     IconActionView(systemName: "hand.thumbsdown", text: "1K", isActive: $isActive) { }
                     
                     IconActionView(systemName: "square.and.arrow.up", text: "Share", isActive: $isActive) { }
                     
                     IconActionView(systemName: "square.and.arrow.down", text: "Download", isActive: $isActive) { }
                     
                    // IconActionView(systemName: "message", text: "Live Chat", isActive: $isActive) { }
                 }
                 .frame(maxWidth: .infinity)
             }
             .background( Color.white)
             
             
         }
         
         
         
     }
 }

 */
