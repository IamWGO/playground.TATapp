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
    
    var placeSearchTypeItems: [CategoryModel] = searchTypeItems
    
    var body: some View {
        VStack(spacing: 0) {
            // Menu Icon
            HStack{
                if isShowBackButton {
                    IconWithRoundBackgroundActionView(systemName: "chevron.backward", action: {
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
                
                HStackButtonActionView(systemName: .constant("line.3.horizontal.decrease"),
                                       textButton: .constant(mainVM.local.getText("search")),
                                       foregroundColor: .constant(Color.theme.primary),
                                       isDisable: .constant(false)) {
                   
                    mainVM.isShowFillterSheet = true
                    mainVM.isShowCategotyMenu = false
                     
                }
                
                ForEach(placeSearchTypeItems) { item in
                    
                    HStackButtonActionView(systemName: .constant(item.systemName),
                                           textButton: .constant(mainVM.local.getText(item.name)),
                                           foregroundColor: .constant(item.backgroundColor),
                                           isDisable: .constant(false)) {
                        mainVM.currentPlaceType = item.placeType
                        mainVM.isShowCategotyMenu = false
                        mainVM.isShowFillterSheet = false
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
