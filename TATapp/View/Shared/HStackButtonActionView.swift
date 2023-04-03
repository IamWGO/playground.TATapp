//
//  IconActionView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-03.
//

import SwiftUI

struct HStackButtonActionView: View {
    @State var systemName: String?
    @State var textButton: String?
    @State var foregroundColor = Color.accentColor
    @State var alignment: HorizontalAlignment = .center
    @Binding var isActive: Bool
    
    var action: () -> Void
    
    var body: some View {
        
        Button(action: {}, label: {
            VStack(alignment: alignment){
                if let systemName = systemName {
                    Image(systemName: systemName)
                        .modifier(TextModifier(fontStyle: .title, foregroundColor: foregroundColor))
                }
                if let textButton = textButton {
                    Text(textButton)
                        .fontWeight(.semibold)
                        .modifier(TextModifier(fontStyle: .body, foregroundColor: foregroundColor))
                }
            }
            .padding(.horizontal)
        })
        
        
    }
}

struct HStackButtonActionView_Previews: PreviewProvider {
    static var previews: some View {
        HStackButtonActionView(systemName: "pin", textButton: "Map" ,isActive: .constant(true)) {
            
        }
    }
}
