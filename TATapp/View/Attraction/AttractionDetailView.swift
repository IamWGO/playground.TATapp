//
//  AttractionDetailView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-06.
//

import SwiftUI
import MapKit

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
            
            ScrollView(showsIndicators: false){
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
            
            
            if vm.isOpenHoursDialog {
                openHoursDialog
            }
            
        }
        .sheet(isPresented: $vm.isShowMapSheet, content: {
           // DispatchQueue.main.async {}
            MapSheetView(mainVM: mainVM, placeItem: placeItem)
        })
        .sheet(isPresented: $vm.isShowMoreImagesSheet, content: {
            //
        })
       
        .ignoresSafeArea()
    }
}

struct AttractionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AttractionDetailView(mainVM: MainViewModel())
    }
}

extension AttractionDetailView {
    
    private var topAreaSection: some View {
        HStack(alignment: .top, spacing: 8){
            TopAreaIconActionView(systemName: "chevron.backward", action: {
                // do something
            })
            
            Spacer()
            if vm.offset < 250 {
                VStack {
                    TopAreaIconActionView(systemName: "photo.on.rectangle.angled", action: {
                        vm.toggleMoreImageIcon()
                    })
                    
                    TopAreaIconActionView(systemName: "square.and.arrow.up", action: {
                        vm.toggleSharedIcon()
                    })
                    
                    TopAreaIconActionView(systemName: "clock", action: {
                        vm.toggleClockIcon()
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
                
                Spacer()
                VStackButtonActionView(systemName: .constant(vm.isLiked ? "hand.thumbsup.fill" : "hand.thumbsup"),
                                       textButton: .constant("123K"),
                                       foregroundColor: .constant(vm.isLiked ? Color.theme.active : Color.theme.inactive),
                                       isDisable: $vm.isLiked) {
                    vm.saveLiked()
                }
            
                Spacer()
                VStackButtonActionView(systemName: .constant(vm.isBookMark ? "bookmark.fill" : "bookmark"),
                                       textButton: .constant("Saved"),
                                       foregroundColor: .constant(vm.isBookMark ? Color.theme.active : Color.theme.inactive),
                                       isDisable: $vm.isBookMark) {
                    vm.saveBookmark()
                }
                
                Spacer()
                VStackButtonActionView(systemName: .constant("map"),
                                       textButton: .constant("Map"),
                                       foregroundColor: .constant(vm.isShowMapSheet ? Color.theme.active : Color.theme.inactive),
                                       isDisable: .constant(!placeItem.isHasLocation())) {
                    
                    vm.toggleMapIcon()
                }
                
                
                Spacer()
                VStackButtonActionView(systemName: .constant("bubble.right"),
                                       textButton: .constant("Review"),
                                       foregroundColor: .constant(vm.isCommentSheet ? Color.theme.active : Color.theme.inactive),
                                       isDisable: $vm.isCommentSheet) {
                    vm.toogleComentIcon()
                }
            }
            .frame(maxWidth: .infinity)
        })
        .padding(.bottom)
        
    }
    
    private var openHoursDialog: some View {
        ZStack(alignment: .top){
            Rectangle()
                .fill(Color.theme.primary.opacity(0.3))
                .onTapGesture {
                    vm.toggleClockIcon()
                }
            
            VStack {
                
                if let openingHours = placeItem.openingHours {
                    VStack(alignment: .trailing, spacing: 8) {
                        
                        VStack {
                            if openingHours.openNow {
                                Text("Open Now")
                                    .modifier(TextModifier(fontStyle: .body))
                            } else {
                                Text("Close Now")
                                    .modifier(TextModifier(fontStyle: .body, foregroundColor: Color.red))
                            }
                        }.padding(.bottom)
                        
                        getOpenHours(day: openingHours.weekdayText.day1.day,
                                     time: openingHours.weekdayText.day1.time)
                        
                        getOpenHours(day: openingHours.weekdayText.day2.day,
                                     time: openingHours.weekdayText.day2.time)
                        
                        getOpenHours(day: openingHours.weekdayText.day3.day,
                                     time: openingHours.weekdayText.day3.time)
                        
                        getOpenHours(day: openingHours.weekdayText.day4.day,
                                     time: openingHours.weekdayText.day4.time)
                        
                        getOpenHours(day: openingHours.weekdayText.day5.day,
                                     time: openingHours.weekdayText.day5.time)
                        
                        getOpenHours(day: openingHours.weekdayText.day6.day,
                                     time: openingHours.weekdayText.day6.time)
                        
                        getOpenHours(day: openingHours.weekdayText.day7.day,
                                     time: openingHours.weekdayText.day7.time)
                        
                    }
                    .padding(20)
                    .background(Color.theme.background)
                    .cornerRadius(20)
                    .offset(y: 20)
                    .shadow(
                        color: Color.theme.primary.opacity(0.25),
                        radius: 10, x: 0, y: 0)
                }
            }
           // .frame(height: kScreen.height * 0.5)
            .padding(.top, 210)
        }
    }
    
    func getOpenHours(day: String, time: String)  -> some View {
       return HStack {
            Text(day)
               .modifier(TextModifier(fontStyle: .body))
            Spacer()
            Text(time)
                .modifier(TextModifier(fontStyle: .body))
        }
       .frame(width: isIpad ? 350 : 300)
    }
}
