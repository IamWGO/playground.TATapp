//
//  PlaceListView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-09.
//

import SwiftUI

struct PlaceListView: View {
   
    @EnvironmentObject var mainVM: MainViewModel
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 1)
    
    @State private var isLoding = false
    
    // MARK: - Body View
    var body: some View {
        ZStack {
            MainMenuView()
            if let placeSearchItems =  mainVM.placeSearchItems {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns,spacing: 30){
                        ForEach(placeSearchItems){ placeSearchItem in
                            Button {
                                isLoding = true
                                mainVM.getPlaceDetail(placeSearchItem: placeSearchItem)
                            } label: {
                                getPlaceItemUI(placeSearchItem: placeSearchItem)
                            }
                            
                            if let _ = mainVM.$selectedPlaceDetail {
                                NavigationLink(destination: PlaceDetailView(), isActive: .constant((mainVM.selectedPlaceDetail != nil) ? true : false)) {
                                    EmptyView()
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top,25)
                    
                }
                if isLoding {
                    LoadingView()
                }
            } else {
                LoadingView()
            }
            
        }
        .onReceive(mainVM.$selectedPlaceDetail, perform: { placeDetail in
            if let _ = placeDetail {
                isLoding = false
            }
        })
        .background(BackgroundImageView())
       // .ignoresSafeArea()
    }
    
    
    private func getPlaceItemUI(placeSearchItem: PlaceItem) -> some View {
        
        return ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            
            VStack(alignment: .leading, spacing: 20) {
                
                Text(placeSearchItem.placeName)
                    .modifier(TextModifier(fontStyle: .body, fontWeight: .bold, foregroundColor: Color.white))
                
                Text(placeSearchItem.location.province)
                    .modifier(TextModifier(fontStyle: .body))
                    .padding(.top,10)
                
                HStack{
                    
                    Spacer(minLength: 0)
                    
                    Text("OK")
                        .foregroundColor(.white)
                }
            }
            .padding()
            // image name same as color name....
            .background(Color.theme.button)
            .cornerRadius(20)
            // shadow....
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            
            // top Image....
            PlaceImageView(imageName: placeSearchItem.thumbnailUrl)
                .frame(width: 20)
                .padding()
                .background(Color.white.opacity(0.12))
                .clipShape(Circle())
            
        }
    }
    
}

