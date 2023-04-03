//
//  SwipeToGetMainMenuModifier.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-07.
//

import SwiftUI

struct SwipeToGetMainMenuModifier: ViewModifier {
    @Binding var isShowCategotyMenu: Bool
    @State var swipeDirection: SwipeDirection = .notAllow
    @State var isAllowLeftSwipe: Bool = true
    @State var isAllowRightSwipe: Bool = true
    
    func body(content: Content) -> some View {
        content
            .modifier(SwipeGestureModifier( swipeDirection: $swipeDirection ))
            .onChange(of: swipeDirection) { direction in
                if  direction == SwipeDirection.up && isShowCategotyMenu  {
                    isShowCategotyMenu = false
                }
                if  direction == SwipeDirection.down  {
                    isShowCategotyMenu = true
                }
                swipeDirection = .notAllow
            }
        
    }
}
