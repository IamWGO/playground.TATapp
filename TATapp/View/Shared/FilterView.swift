//
//  FilterView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-19.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject var mainVM: MainViewModel
    
    var placeSearchTypeItems: [CategoryModel] = searchTypeItems
    
    var body: some View {
        VStack{
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(placeSearchTypeItems){ item in
                        Button {
                            mainVM.currentPlaceType = item.placeType
                        } label: {
                            getCard(item: item)
                        }
                    }
                }
            }
            .frame(height: 80)
        }
        .padding(.top, mainVM.getTopSafeAreaSize() + 30)
    }
    
    func getCard(item: CategoryModel) -> some View {
        return ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            
            HStack(spacing: 10) {
                Image(systemName: item.systemName)
                    .resizable()
                    .scaledToFit()
                    .font(.caption2)
                    .frame(height: 18)
                    .foregroundColor(item.foregroundColor)
                
                Text(mainVM.local.getText(item.name))
                    .modifier(TextModifier(fontStyle: .body, fontWeight: .bold, foregroundColor: item.foregroundColor))
            }
            //.frame(minWidth: isIpad ? 200 : 150)
            .padding(.vertical, 8)
            .padding(.horizontal)
            .modifier(FullWidthModifier())
            // image name same as color name....
            .background(item.backgroundColor)
            .cornerRadius(10)
            // shadow....
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
