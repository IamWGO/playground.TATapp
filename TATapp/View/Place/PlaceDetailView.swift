//
//  PlaceDetailView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-03.
//

import SwiftUI

struct PlaceDetailView: View {
    @StateObject var homeData = HomeViewModel()
    
    @State var placeItem: PlaceItemModel = DummyplaceItem
   
    // For Dark Mode Adoption....
    @Environment(\.colorScheme) var scheme
    var body: some View {
        
        ScrollView{
            
            // Since Were Pinning Header View....
            LazyVStack(alignment: .leading, spacing: 15, pinnedViews: [.sectionHeaders], content: {
                
                // Parallax Header....
                
                GeometryReader{reader -> AnyView in
                    
                    let offset = reader.frame(in: .global).minY
                    
                    if -offset >= 0{
                        DispatchQueue.main.async {
                            self.homeData.offset = -offset
                        }
                    }
                    
                    return AnyView(
                    
                        PlaceImageView(imageName: placeItem.thumbnailUrl)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: 250 + (offset > 0 ? offset : 0))
                            .cornerRadius(2)
                            .offset(y: (offset > 0 ? -offset : 0))
                            .overlay(
                            
                                HStack{
                                    
                                    Button(action: {}, label: {
                                        Image(systemName: "arrow.left")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.white)
                                    })
                                    
                                    Spacer()
                                    
                                    Button(action: {}, label: {
                                        Image(systemName: "suit.heart.fill")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.white)
                                    })
                                }
                                .padding(),
                                alignment: .top
                            )
                    )
                }
                .frame(height: 250)
                
                // Cards......
                
                Section(header: PlaceHeaderView()) {

                    // Tabs With Content.....
                    
                    ForEach(tabsItems){tab in
                        
                        VStack(alignment: .leading, spacing: 15, content: {
                            
                            Text(tab.tab)
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.bottom)
                                .padding(.leading)
                            
                            ForEach(tab.foods){food in
                                
                                CardView(food: food)
                            }
                            
                            Divider()
                                .padding(.top)
                        })
                        .tag(tab.tab)
                       /* .overlay(
                        
                            GeometryReader{reader -> Text in
                                
                                // Calculating Whicj tab....
                                
                                let offset = reader.frame(in: .global).minY
                                
                                // Top Area Plus Header Size 100
                                let height = UIApplication.shared.windows.first!.safeAreaInsets.top + 100
                                
                                if offset < height && offset > 50 && homeData.selectedtab != tab.tab{
                                    DispatchQueue.main.async {
                                        self.homeData.selectedtab = tab.tab
                                    }
                                }
                                
                                return Text("")
                            }
                        )*/
                    }
                }
            })
        }
        .overlay(
        
            // Only Safe Area....
            (scheme == .dark ? Color.black : Color.white)
                .frame(height: UIApplication.shared.windows.first?.safeAreaInsets.top)
                .ignoresSafeArea(.all, edges: .top)
                .opacity(homeData.offset > 250 ? 1 : 0)
            ,alignment: .top
        )
        // Used It Environment Object For Accessing All SUb Objects....
        .environmentObject(homeData)
    }
}

struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailView()
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
