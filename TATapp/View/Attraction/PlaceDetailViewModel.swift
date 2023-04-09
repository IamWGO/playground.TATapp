//
//  AttractionViewModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-07.
//

import SwiftUI

class PlaceDetailViewModel: ObservableObject {
    @Published var isLiked: Bool = false
    @Published var isBookMark: Bool = false
    @Published var isCommentSheet: Bool = false
    @Published var isShowMapSheet: Bool = false
    @Published var isShowMoreImagesSheet: Bool = false
    @Published var isShowSharedSheet: Bool = false
    @Published var isOpenHoursDialog: Bool = false
    
    
    @Published var offset: CGFloat = 0

    func saveLiked(){
        // TODO : - Save to database
        isLiked = !isLiked
        
        print("isLike > \(isLiked)")
    }
    
    func saveBookmark(){
        // TODO : - Save to database
        isBookMark = !isBookMark
    }
    
    func toogleComentIcon(){
        // TODO : - Save to database
        withAnimation(.easeInOut) {
            isCommentSheet = !isCommentSheet
        }
    }
    
    func toggleMapIcon() {
        isShowMapSheet = !isShowMapSheet
    }
    
    func toggleClockIcon() {
        withAnimation(.easeInOut) {
            isOpenHoursDialog = !isOpenHoursDialog
        }
    }
    
    func toggleMoreImageIcon(){
        isShowMoreImagesSheet = !isShowMoreImagesSheet
    }
    
    func toggleSharedIcon(){
        isShowSharedSheet = !isShowSharedSheet
    }
    
    func getOffsetType() -> CGFloat {
        if offset > 200{
            let progress = (offset - 200) / 50
            
            if progress <= 1.0{
                return progress * 40
            }
            else{
                return 40
            }
        }
        else{
            return 0
        }
    }
}
