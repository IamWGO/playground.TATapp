//
//  MenuListView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-07.
//

import SwiftUI

struct MainMenuView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mainVM: MainViewModel
    
    @State var isShowBackButton: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Menu Icon
            HStack{
                if isShowBackButton {
                    TopAreaIconActionView(systemName: "chevron.backward", action: {
                        presentationMode.wrappedValue.dismiss()
                    })
                }
                
                Spacer()
                menuIcon
            }
            .padding(.horizontal)
            // Menu List
            if mainVM.isShowCategotyMenu {
                menuItems
            }
            Spacer()
            
        }
        .padding(.top, mainVM.getTopSafeAreaSize())
    }
    
    var menuIcon: some View {
        VStack {
            Button {
                mainVM.toggleMenuIcon()
            } label: {
                Image(systemName: "text.justify")
                    .font(.body)
                    .foregroundColor(Color.theme.primary)
                    .padding(10)
                    .rotationEffect(Angle(degrees: mainVM.isShowCategotyMenu ? 180 : 0))
            }
        }
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
    
    var menuItems: some View {
        HStack{
            Spacer()
            VStack(alignment: .trailing) {
                ForEach(categoryItems) { item in
                    
                    Button {
                        mainVM.currentPlaceType = item.placeType
                    } label: {
                        HStack(spacing: 8){
                            
                            Image(systemName: item.systemName)
                                .modifier(TextModifier(fontStyle: .title, foregroundColor: item.backgroundColor))
                            
                            Text(item.name)
                                .fontWeight(.semibold)
                                .modifier(TextModifier(fontStyle: .body, foregroundColor: item.foregroundColor))
                            
                            Spacer()
                        }
                        .frame(width: isIpad ? 300 : 200)
                        .padding([.horizontal, .bottom])
                    }
                }
            }
            .padding(.vertical)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
                   // .offset(y: 30)
            )
        }
        .padding(.horizontal)
    }
}

struct MenuListView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
