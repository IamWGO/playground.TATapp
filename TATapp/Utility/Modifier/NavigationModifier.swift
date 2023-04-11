//
//  NavigationModifier.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-09.
//

import SwiftUI

struct HiddenNavigationBarModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

struct NavigationBarTitleModifier : ViewModifier {
    var titleBar: String
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text(titleBar)
                            .modifier(TextModifier(fontStyle: .body, fontWeight: .bold))
                            .modifier(ShadowModifier())
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
    }
}

struct ShadowModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(
                color: Color.theme.primary.opacity(0.25),
                radius: 10, x: 0, y: 0)
    }
}
