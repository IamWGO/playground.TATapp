//
//  TitleTextModifier.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-05.
//

import SwiftUI

struct FullWidthModifier : ViewModifier {
    func body(content: Content) -> some View {
        content.frame(
            minWidth: 0,
            maxWidth: .infinity
        )
    }
}
