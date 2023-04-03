//
//  VStackButtonActionView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-06.
//

import SwiftUI

 
struct VStackButtonActionView: View {
    @State var systemName: String?
    @State var textButton: String?
    @State var foregroundColor = Color.accentColor
    @State var backgroundColor = Color.white
    
    @Binding var isActive: Bool
    
    var action: () -> Void
    
    var body: some View {
        
        Button(action: {}, label: {
            HStack(spacing: 8){
                if let systemName = systemName {
                    Image(systemName: systemName)
                        .modifier(TextModifier(fontStyle: .title, foregroundColor: foregroundColor))
                }
                
                if let textButton = textButton {
                    Text(textButton)
                        .modifier(TextModifier(fontStyle: .body, foregroundColor: foregroundColor))
                }
            }
            .padding(.horizontal)
        })
        .frame(width: kScreen.width * 0.7)
        .padding()
        .background(backgroundColor)
        .cornerRadius(22)
        .shadow(
            color: Color.theme.primary.opacity(0.25),
            radius: 10, x: 0, y: 0)
    }
}


struct VStackButtonActionView_Previews: PreviewProvider {
    static var previews: some View {
        VStackButtonActionView(isActive: .constant(true)) {
            
        }
    }
}
