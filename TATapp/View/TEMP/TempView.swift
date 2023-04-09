//
//  TempView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-06.
//

import SwiftUI 

struct GridView : View {
    @EnvironmentObject var mainVM: MainViewModel
    
    var dataItems: [CategoryModel] = categoryItems
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
   
    var body: some View{
        
        LazyVGrid(columns: columns,spacing: 5){
            
            ForEach(dataItems){ item in
                
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                    
                    VStack(spacing: 20) {
                        Image(systemName: item.systemName)
                            .resizable()
                            .scaledToFit()
                            .font(.largeTitle)
                            .frame(height: 50)
                            .foregroundColor(item.foregroundColor)
                        
                        Text(item.name)
                            .modifier(TextModifier(fontStyle: .body, fontWeight: .bold, foregroundColor: item.foregroundColor))
                    }
                    .padding()
                    .modifier(FullWidthModifier())
                    // image name same as color name....
                    .background(item.backgroundColor)
                    .cornerRadius(20)
                    // shadow....
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                }
                
                 
            }
        }
        .padding(.horizontal)
        .padding(.top,25)
    }
    
    /*
    private var header : some View {
        VStack(alignment: .leading) {
            Text(localVM.landingString["subHeader"] ?? "sub-header")
                .modifier(TextModifier(fontStyle: .title, fontWeight: .bold))
            Text(localVM.landingString["header"] ?? "header")
                .modifier(TextModifier(fontStyle: .large, fontWeight: .regular))
        }
    }*/
    
    private var logo: some View {
        Image("logo")
            .resizable()
            .scaledToFit()
            .frame(width: 55)
            .clipShape(Circle())
    }
    
    private var templte: some View {
        ZStack {
            
            VStack(spacing: 0) {
                // Menu Icon
                HStack{
                    Spacer()
                    //MenuIconButtonView(isShowMenu: $vm.isShowCategotyMenu)
                    MenuIconButtonView(isShowMenu: .constant(true))
                }
                .padding(.horizontal)
                // Menu List
               /* if vm.isShowCategotyMenu {
                   MainMenuView(currentPlaceType: $mainVM.currentPlaceType)
                }*/
                Spacer()
                
            }
            .padding(.top, mainVM.getTopSafeAreaSize())
        }
        //.background(backgroundImage)
        .ignoresSafeArea()
        //.modifier(SwipeToGetMainMenuModifier(isShowCategotyMenu: $vm.isShowCategotyMenu))
    }
     
}

/*
struct GridView : View {
    var placeItems : [PlaceItem]
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    var body: some View{
        
        
    }
}

*/
