//
//  AttractionDetailView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-06.
//

import SwiftUI

struct AttractionDetailView: View {
    @EnvironmentObject var mainVM: MainViewModel
    @ObservedObject var vm: AttractionViewModel
    @Environment(\.colorScheme) var scheme
    
    @State var placeItem = DummyAttractionDetail
    
    init(mainVM: MainViewModel){
        _vm = ObservedObject(wrappedValue: AttractionViewModel(mainVM: mainVM))
    }
    
    @State var isShowMap: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            
            ScrollView{
                
                // Since Were Pinning Header View....
                LazyVStack(alignment: .leading, spacing: 15, pinnedViews: [.sectionHeaders], content: {
                    
                    // Parallax Header....
                    GeometryReader{ reader -> AnyView in
                        
                        let offset = reader.frame(in: .global).minY
                        
                        if -offset >= 0{
                            DispatchQueue.main.async {
                                self.vm.offset = -offset
                            }
                        }
                        
                        return AnyView(
                            PlaceImageView(imageName: placeItem.thumbnailUrl)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width, height: 250 + (offset > 0 ? offset : 0))
                                .cornerRadius(2)
                                .offset(y: (offset > 0 ? -offset : 0))
                            )
                    }
                    .frame(height: 250)
                    
                    // Cards......
                    Section(header: headerView) {
                        // Tabs With Content.....
                        contentBody
                    }
                })
            }
            .overlay(
                // Only Safe Area....
                (scheme == .dark ? Color.black : Color.white)
                    .frame(height: mainVM.getTopSafeAreaSize())
                    .ignoresSafeArea(.all, edges: .top)
                    .opacity(vm.offset > 250 ? 1 : 0)
                ,alignment: .top
            )
            
            
            // Will always show on top of content
            topArea
            
        }
       // .background(BackgroundImageView())
        .ignoresSafeArea()
    }
    
    private var shortdetail: some View {
        
        VStack(alignment: .leading, spacing: 0){
            ZStack{
                
                VStack(alignment: .leading, spacing: 10, content: {
                    headerDescription
                })
                .opacity(vm.offset > 200 ? 1 - Double((vm.offset - 200) / 50) : 1)
                 
            }
            // Default Frame = 60...
            // Top Fram = 40
            // So Total = 100
            .frame(height: 60)
    
            if vm.offset > 250{
                headerDescription
            }
        }
        .padding(.horizontal)
        .frame(height: vm.offset > 250 ? 150 : 100)
        .background(scheme == .dark ? Color.black : Color.white)
        
    }
    
    
    private var headerDescription: some View {
        VStack(alignment: .leading, spacing: 3, content: {
            HStack{
                Spacer()
                Text(placeItem.placeName)
                    .modifier(TextModifier(fontStyle: .title3, fontWeight: .semibold))
                Spacer()
                
            }
            .padding(.bottom)
            
            Text(placeItem.sha.shaTypeDescription)
                .modifier(TextModifier(fontStyle: .caption))
            
            HStack(spacing: 8){
                
                Image(systemName: "mappin.and.ellipse")
                    .font(.caption)
                Text(mainVM.getDistrictAndProvince(location: placeItem.location))
                    .modifier(TextModifier(fontStyle: .caption))
               
                
                Spacer()
                
                Image(systemName: "phone")
                    .modifier(TextModifier(fontStyle: .caption))
                
                Text(placeItem.contact.phones?[0] ?? "")
                    .font(.caption)
                    .modifier(TextModifier(fontStyle: .caption))
            }
            .frame(maxWidth: .infinity,alignment: .leading)
        })
        .padding(.bottom)
        
    }
    
    private var topArea: some View {
        HStack{
            Image(systemName: "chevron.backward")
                .font(.body)
                .padding(15)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
            
            Spacer()
            
            Image(systemName: "suit.heart.fill")
                .font(.body)
                .padding(10)
                .foregroundColor(.red)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
            //suit.heart  suit.heart.fill
        }
        .padding(.top, mainVM.getTopSafeAreaSize())
        .padding(.horizontal)
    }
    
    var headerView: some View {
        VStack(alignment: .leading, spacing: 0){
            ZStack{
                shortdetail
            }
            // Default Frame = 60...
            // Top Fram = 40
            // So Total = 100
            .frame(height: 60)
    
            if vm.offset > 250{
              
            }
        }
        .frame(height: vm.offset > 250 ? 150 : 100)
        .background(scheme == .dark ? Color.black : Color.white)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color.primary.opacity(vm.offset > 250 ? 0.2 : 0))
                .frame(height: 1)
                .shadow(
                    color: Color.theme.primary.opacity(0.25),
                    radius: 10, x: 0, y: 0)
        }
       
    }
    
    var contentBody: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(placeItem.placeInformation.detail)
                .modifier(TextModifier(fontStyle: .body))
            Spacer()
        }.padding()
    }
}

struct AttractionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AttractionDetailView(mainVM: MainViewModel())
    }
}
