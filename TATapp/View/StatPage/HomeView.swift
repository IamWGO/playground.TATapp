//
//  HomeView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-08.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var mainVM: MainViewModel
    
    @State private var shouldNavigate = false
    
    var dataItems: [CategoryModel] = categoryItems
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    var body: some View {
        
        ZStack {
            MainMenuView()
            LazyVGrid(columns: columns,spacing: 5){
                
                ForEach(dataItems){ item in
                    Button {
                        mainVM.currentPlaceType = item.placeType
                    } label: {
                        getCard(item: item)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top,25)
        }
        .onAppear {
            self.shouldNavigate = false
        }
        .onChange(of: mainVM.currentPlaceType, perform: { placeType in
            if let _ = placeType {
                self.shouldNavigate = true
            }
        })
        .background(
            NavigationLink(destination: PlaceListView(), isActive: $shouldNavigate) {
                EmptyView()
            }
        )
        .ignoresSafeArea()
        //.modifier(SwipeToGetMainMenuModifier(isShowCategotyMenu: $mainVM.isShowCategotyMenu))
    }
    
    
    func getCard(item: CategoryModel) -> some View {
        return ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
