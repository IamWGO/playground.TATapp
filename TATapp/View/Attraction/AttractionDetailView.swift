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
    
    @State var testIsLiked: Bool = false
    
    init(mainVM: MainViewModel){
        _vm = ObservedObject(wrappedValue: AttractionViewModel(mainVM: mainVM))
    }
    
    @State var isShowMap: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            
            ScrollView{
                bodyContainer
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
            topAreaSection
            
        }
        .sheet(isPresented: $vm.isShowMapSheet, content: {
            MapSheetView()
        })
        .ignoresSafeArea()
    }
    
    private var topAreaSection: some View {
        HStack(alignment: .top, spacing: 8){
            TopAreaIconActionView(systemName: "chevron.backward", action: {
                // do something
            })
            
            Spacer()
            if vm.offset < 250 {
                VStack {
                    TopAreaIconActionView(systemName: "photo.on.rectangle.angled", action: {
                        //share this page
                    })
                    
                    TopAreaIconActionView(systemName: "square.and.arrow.up", action: {
                        //share this page
                    })
                }
            }
           
        }
        .padding(.top, mainVM.getTopSafeAreaSize())
        .padding(.horizontal)
    }
    
    private var bodyContainer: some View {
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
            Section(header: headerSection) {
                // Content Detail.....
                VStack(alignment: .leading, spacing: 15) {
                    Text(placeItem.placeInformation.detail)
                        .modifier(TextModifier(fontStyle: .body))
                    Spacer()
                }.padding()
            }
        })
    }
    
    var headerSection: some View {
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
        .frame(height: vm.offset > 250 ? 200 : 160) //header with top image
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
        .frame(height: vm.offset > 250 ? 100 : 160) // header with now image
        .background(scheme == .dark ? Color.black : Color.white)
        
    }
    
    private var headerDescription: some View {
        VStack(alignment: .leading, spacing: 6, content: {
            
            HStack{
                Spacer()
                Text(placeItem.placeName)
                    .modifier(TextModifier(fontStyle: .title3, fontWeight: .semibold))
                Spacer()
                
            }
            .padding(.horizontal)
            
            Spacer()
            
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
            
            HStack{
                HStackButtonActionView(systemName: .constant(vm.isLiked ? "hand.thumbsup.fill" : "hand.thumbsup"),
                                       textButton: .constant("123K"),
                                       isActive: $vm.isLiked) {
                    vm.saveLiked()
                }
            
                Spacer()
                HStackButtonActionView(systemName: .constant(vm.isBookMark ? "bookmark.fill" : "bookmark"),
                                       textButton: .constant("Saved"),
                                       isActive: $vm.isBookMark) {
                    vm.saveBookmark()
                }
                
                Spacer()
                HStackButtonActionView(systemName: .constant("map"),
                                       textButton: .constant("Map"),
                                       isActive: $vm.isShowMapSheet) {
                    vm.toggleMapIcon()
                }
                
                Spacer()
                HStackButtonActionView(systemName: .constant("bubble.right"),
                                       textButton: .constant("Review"),
                                       isActive: $vm.isCommentSheet) {
                    vm.toogleComentIcon()
                }
            }
            .frame(maxWidth: .infinity)
        })
        .padding(.bottom)
        
    }
}

struct AttractionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AttractionDetailView(mainVM: MainViewModel())
    }
}
