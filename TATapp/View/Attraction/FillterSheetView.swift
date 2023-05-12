//
//  FillterSheetView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-17.
//

import SwiftUI

struct FillterSheetView: View {
    @EnvironmentObject var mainVM: MainViewModel
    @State var provinceItems: [Province] = []
    @State var selectedItems: Province?
    @State var isShowItemList: Bool = false
    
    let maxWidthForIpad: CGFloat = 700
    
    var body: some View {
        VStack(spacing: 0) {
            provinceSearchItem
                .padding(.trailing, 8)
                .padding(.horizontal)
                .frame(maxWidth: maxWidthForIpad)
            Spacer() 
        }
        .padding(.top, mainVM.getTopSafeAreaSize() + 60)
        .padding(.bottom, 25)
    }
    
    private var provinceSearchItem: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 0) {
                if let selectedItems = selectedItems {
                    Button {
                        isShowItemList.toggle()
                    } label: {
                        HStack(spacing: 10){
                            Text(selectedItems.provinceCode)
                                .modifier(TextModifier(fontStyle: .body, alignment: .leading))
                                .frame(height: 55)
                                .animation(.none, value: selectedItems)
                                
                            Spacer()
                           
                            Image(systemName: "arrow.down")
                                .modifier(TextModifier(fontStyle: .title3))
                                .foregroundColor(.primary)
                                .padding(isShowItemList ? [.top,.bottom, .leading] : [.top,.bottom, .trailing])
                                .rotationEffect(Angle(degrees: isShowItemList ? 180 : 0))
                        }.padding(.leading, 15)
                    }
                }
                if isShowItemList {
                    provinceList
                }
            }
            .background(.thickMaterial)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
            .offset(y: -10)
        }
       
    }
    
    var provinceList: some View {
        List {
            ForEach(provinceItems) { provinceItem in
                Button {
                    //todo
                } label: {
                    Text(provinceItem.provinceNameEn)
                        .font(.headline)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct FillterSheetView_Previews: PreviewProvider {
    static var previews: some View {
        FillterSheetView()
    }
}
