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
                    HStackButtonActionView(systemName: .constant("hand.thumbsup"),
                                           textButton: .constant("123K"),
                                           isActive: .constant(true)) {
                       // vm.saveLiked()
                    }
                
                    Spacer()
                    HStackButtonActionView(systemName: .constant("bookmark"),
                                           textButton: .constant("Saved"),
                                           isActive: .constant(true)) {
                        //vm.saveBookmark()
                    }
                    
                    Spacer()
                    HStackButtonActionView(systemName: .constant("map"),
                                           textButton: .constant("Map"),
                                           isActive: .constant(true)) {
                        //vm.toggleMapIcon()
                    }
                    
                    Spacer()
                    HStackButtonActionView(systemName: .constant("bubble.right"),
                                           textButton: .constant("Review"),
                                           isActive: .constant(true)) {
                        //vm.toogleComentIcon()
                    }
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
