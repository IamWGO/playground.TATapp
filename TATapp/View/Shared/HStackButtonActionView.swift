//
//  HStackButtonActionView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-17.
//

import SwiftUI

struct HStackButtonActionView: View {
    @Binding var systemName: String
    @Binding var textButton: String
    @Binding var foregroundColor: Color
    @Binding var isDisable: Bool
    @State var alignment: HorizontalAlignment = .center
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            HStack(spacing: 8){
                
                Image(systemName: systemName)
                    .modifier(TextModifier(fontStyle: .title, foregroundColor: foregroundColor))
                
                Text(textButton)
                    .fontWeight(.semibold)
                    .modifier(TextModifier(fontStyle: .body, foregroundColor: Color.theme.primary))
                
                Spacer()
            }
            .frame(width: isIpad ? 300 : 200)
            .padding([.horizontal, .bottom])
        })
    }
}
