//
//  PlaceSearchCard.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-03.
//

import SwiftUI

struct PlaceSearchCard: View {
    
    @ObservedObject var mainVM = MainViewModel()
    @State var isActive = false
    
    @State var placeItem: PlaceItemModel = DummyplaceItem
    
    var body: some View {
        
        ZStack(alignment:.bottom) {
            
            PlaceImageView(imageName: placeItem.thumbnailUrl) 
            
            VStack(alignment: .leading, spacing: 18){
                
                // Video Playback Details And Buttons....
                VStack(alignment: .leading, spacing: 8, content: {
                    HStack{
                        Text(placeItem.placeName)
                            .font(.body)
                        Spacer()
                       Text(mainVM.placeSearchService.getShaTypeDescription(sha: placeItem.sha))
                           .font(.caption)
                           .fontWeight(.bold)
                           .foregroundColor(.gray)
                    }
                    
                    HStack{
                        Text(mainVM.placeSearchService.getAddress(location: placeItem.location))
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                         
                    }
                    
                })
                
                // Buttons....
                
                HStack{
                    IconActionView(systemName: "hand.thumbsup", text: "123K", isActive: $isActive) { }
                    Spacer()
                    IconActionView(systemName: "bookmark", text: "Saved", isActive: $isActive) { }
                    
                    Spacer()
                    IconActionView(systemName: "map", text: "Map", isActive: $isActive) { }
                    Spacer()
                    IconActionView(systemName: "square.and.arrow.up", text: "Share", isActive: $isActive) { }
                    
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .background( Color.white)
            
            
            Rectangle()
                .fill(Color.gray.opacity(0.7))
                .frame(maxWidth: .infinity, maxHeight: 2)
        }
        .frame(maxHeight: 100)
        
    }
}

struct PlaceSearchCard_Previews: PreviewProvider {
    static var previews: some View {
        PlaceSearchCard()
    }
}
