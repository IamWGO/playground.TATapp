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
    
    @State var placeItem: PlaceSearchItem
    
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
                    VStackButtonActionView(systemName: .constant("hand.thumbsup"),
                                           textButton: .constant("123K"),
                                           foregroundColor: .constant(Color.primary),
                                           isDisable: .constant(true)) {
                       // vm.saveLiked()
                    }
                
                    Spacer()
                    VStackButtonActionView(systemName: .constant("bookmark"),
                                           textButton: .constant("Saved"),
                                           foregroundColor: .constant(Color.primary),
                                           isDisable: .constant(true)) {
                        //vm.saveBookmark()
                    }
                    
                    Spacer()
                    VStackButtonActionView(systemName: .constant("map"),
                                           textButton: .constant("Map"),
                                           foregroundColor: .constant(Color.primary),
                                           isDisable: .constant(true)) {
                        //vm.toggleMapIcon()
                    }
                    
                    Spacer()
                    VStackButtonActionView(systemName: .constant("bubble.right"),
                                           textButton: .constant("Review"),
                                           foregroundColor: .constant(Color.primary),
                                           isDisable: .constant(true)) {
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
