//
//  IconActionView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-03.
//

import SwiftUI

struct HStackButtonActionView: View {
    @Binding var systemName: String?
    @Binding var textButton: String?
    @Binding var isActive: Bool
    @State var alignment: HorizontalAlignment = .center
    
    
    var action: () -> Void
    
    var body: some View {
        
        Button(action: action, label: {
            VStack(alignment: alignment, spacing: 4){
                if let systemName = systemName {
                    Image(systemName: systemName)
                        .font(.body)
                        .foregroundColor(isActive ? Color.theme.active : Color.theme.inactive)
                }
                if let textButton = textButton {
                    Text(textButton)
                        .font(.caption)
                        .foregroundColor(isActive ? Color.theme.active : Color.theme.inactive)
                }
            }
            .padding(.horizontal)
        })
        
    }
}

struct HStackButtonActionView_Previews: PreviewProvider {
    static var previews: some View {
        HStackButtonActionView(systemName: .constant("map"), textButton: .constant("Map"),isActive: .constant(true)) {
            
        }
    }
}
