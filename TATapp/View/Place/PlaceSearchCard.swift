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
    
    @State var placeItem: PlaceItem = DummyplaceItem
    
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
                        Text(mainVM.getShaTypeDescription(sha: placeItem.sha))
                           .font(.caption)
                           .fontWeight(.bold)
                           .foregroundColor(.gray)
                    }
                    
                    HStack{
                        Text(mainVM.getFullAddress(location: placeItem.location))
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                         
                    }
                    
                })
                
                // Buttons....
                
                HStack{
                    HStackButtonActionView(systemName: "hand.thumbsup", textButton: "123K", isActive: $isActive) { }
                    Spacer()
                    HStackButtonActionView(systemName: "bookmark", textButton: "Saved", isActive: $isActive) { }
                    
                    Spacer()
                    HStackButtonActionView(systemName: "map", textButton: "Map", isActive: $isActive) { }
                    Spacer()
                    HStackButtonActionView(systemName: "square.and.arrow.up", textButton: "Share", isActive: $isActive) { }
                    
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
