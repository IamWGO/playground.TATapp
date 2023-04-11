//
//  PlaceDetailView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-06.
//

import SwiftUI
import MapKit

struct PlaceDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var scheme
    
    @EnvironmentObject var mainVM: MainViewModel
    @ObservedObject var vm: PlaceViewModel = PlaceViewModel()
   
    @State private var isShowMap: Bool = false
    
    var body: some View {
        if let placeItem = mainVM.selectedPlaceDetail {
            ZStack(alignment: .top) {
                if mainVM.isLoading {
                    LoadingView()
                } else {
                    placeItemUI(placeItem: placeItem)
                    .overlay(
                        // Only Safe Area....
                        (scheme == .dark ? Color.black : Color.white)
                            .frame(height: mainVM.getTopSafeAreaSize())
                            .ignoresSafeArea(.all, edges: .top)
                            .opacity(vm.offset > 250 ? 1 : 0)
                        ,alignment: .top
                    )
                    // Will always show on top of content
                    if vm.offset < 250{
                        topAreaSection
                    }
                    
                    if vm.isOpenHoursDialog {
                        openHoursDialog(placeItem: placeItem)
                    }
                }
                
            }
            
            .sheet(isPresented: $vm.isShowMapSheet, content: {
                MapSheetView(mainVM: mainVM, placeItem: placeItem, isShowDetailIcon: false)
            })
            .sheet(isPresented: $vm.isShowMoreImagesSheet, content: {
                //
            })
            .ignoresSafeArea()
        } else {
            LoadingView()
        }
    }
}

extension PlaceDetailView {
    private func placeItemUI(placeItem: PlaceItemModel) -> some View {
        ZStack(alignment: .top) {
            
            ScrollView(showsIndicators: false){
                bodyContainer(placeItem: placeItem)
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
          //  topAreaSection
            
            if vm.isOpenHoursDialog {
                openHoursDialog(placeItem: placeItem)
            }
        }
        .sheet(isPresented: $vm.isShowMapSheet, content: {
           // DispatchQueue.main.async {}
            MapSheetView(mainVM: mainVM, placeItem: placeItem, isShowDetailIcon: false)
        })
        .sheet(isPresented: $vm.isShowMoreImagesSheet, content: {
            //
        })
        .modifier(HiddenNavigationBarModifier())
    }
    
    private var topAreaSection: some View {
        HStack(alignment: .top, spacing: 8){
            IconWithRoundBackgroundActionView(systemName: "chevron.backward", action: {
                presentationMode.wrappedValue.dismiss()
            })
            
            Spacer()
            
            VStack {
                IconWithRoundBackgroundActionView(systemName: "photo.on.rectangle.angled", action: {
                    vm.toggleMoreImageIcon()
                })
                
                IconWithRoundBackgroundActionView(systemName: "square.and.arrow.up", action: {
                    vm.toggleSharedIcon()
                })
                
                IconWithRoundBackgroundActionView(systemName: "clock", action: {
                    vm.toggleClockIcon()
                })
            }
        }
        .padding(.top, mainVM.getTopSafeAreaSize())
        .padding(.horizontal)
    }
    
    private func bodyContainer(placeItem: PlaceItemModel) -> some View {
        // Since Were Pinning Header View....
        return LazyVStack(alignment: .leading, spacing: 15, pinnedViews: [.sectionHeaders], content: {
            
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
            Section(header: headerSection(placeItem: placeItem)) {
                // Content Detail.....
                VStack(alignment: .leading, spacing: 15) {
                    Text(placeItem.placeInformation.detail)
                        .modifier(TextModifier(fontStyle: .body))
                    Spacer()
                }.padding()
            }
        })
    }
    
    private func headerSection(placeItem: PlaceItemModel) -> some View {
     
        return VStack(alignment: .leading, spacing: 0){
            ZStack{
                shortdetail(placeItem: placeItem)
            }
            // Default Frame = 60...
            // Top Fram = 40
            // So Total = 100
            .frame(height: 60)
        }
        .frame(height: vm.offset > 250 ? 200 : 140) //header with top image
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
    
    private func shortdetail(placeItem: PlaceItemModel) -> some View {
    
       return VStack(alignment: .leading, spacing: 0){
            ZStack{
                
                VStack(alignment: .leading, spacing: 10, content: {
                    headerDescription(placeItem: placeItem)
                })
                .opacity(vm.offset > 200 ? 1 - Double((vm.offset - 200) / 50) : 1)
                 
            }
            // Default Frame = 60...
            // Top Fram = 40
            // So Total = 100
            .frame(height: 60)
           
           if vm.offset > 250{
               headerDescription(placeItem: placeItem)
                   .padding(.horizontal)
                   
           }
        }
        .padding(.horizontal)
        .background(scheme == .dark ? Color.black : Color.white)
        
        
    }
    
    private func headerDescription(placeItem: PlaceItemModel) -> some View {
    
       return VStack(alignment: .leading, spacing: 6, content: {
            
           Text(placeItem.placeName)
               .modifier(TextModifier(fontStyle: .title3, fontWeight: .semibold))
           
          
            Spacer()
            
            HStack(spacing: 8){
                
                Image(systemName: "mappin.and.ellipse")
                    .font(.caption)
                Text(mainVM.getDistrictAndProvince(location: placeItem.location))
                    .modifier(TextModifier(fontStyle: .caption))
               
                
                Spacer()
                
                Image(systemName: "phone")
                    .modifier(TextModifier(fontStyle: .caption))
                
                Text(mainVM.getContactNumbers(contacInfo: placeItem.contact))
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
            
        })
        .padding(.top, vm.offset > 250 ? 0 : 20)
        .padding(.bottom)
        
    }
    
    private func openHoursDialog(placeItem: PlaceItemModel) -> some View {
        return ZStack(alignment: .top){
            Rectangle()
                .fill(Color.theme.primary.opacity(0.3))
                .onTapGesture {
                    vm.toggleClockIcon()
                }
            
            VStack {
                
                if let openingHours = placeItem.openingHours {
                    VStack(alignment: .trailing, spacing: 8) {
                        
                        VStack {
                            if let openNow = openingHours.openNow {
                                if openNow {
                                    Text("Open Now")
                                        .modifier(TextModifier(fontStyle: .body))
                                } else {
                                    Text("Close Now")
                                        .modifier(TextModifier(fontStyle: .body, foregroundColor: Color.red))
                                }
                            }
                            
                        }.padding(.bottom)
                        if let weekdayText = openingHours.weekdayText {
                            if let openPeriod = weekdayText.day1 {
                                getOpenHours(day: openPeriod.day, time: openPeriod.time)
                            }
                            if let openPeriod = weekdayText.day2 {
                                getOpenHours(day: openPeriod.day, time: openPeriod.time)
                            }
                            if let openPeriod = weekdayText.day3 {
                                getOpenHours(day: openPeriod.day, time: openPeriod.time)
                            }
                            if let openPeriod = weekdayText.day4 {
                                getOpenHours(day: openPeriod.day, time: openPeriod.time)
                            }
                            if let openPeriod = weekdayText.day5 {
                                getOpenHours(day: openPeriod.day, time: openPeriod.time)
                            }
                            if let openPeriod = weekdayText.day6 {
                                getOpenHours(day: openPeriod.day, time: openPeriod.time)
                            }
                            if let openPeriod = weekdayText.day7 {
                                getOpenHours(day: openPeriod.day, time: openPeriod.time)
                            }
                        }
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
            .padding(.top, 210) // padding top
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
