//
//  IconActionView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-03.
//

import SwiftUI

struct VStackButtonActionView: View {
    @Binding var systemName: String?
    @Binding var textButton: String?
    @Binding var foregroundColor: Color
    @Binding var isDisable: Bool
    @State var alignment: HorizontalAlignment = .center
    
    
    var action: () -> Void
    
    var body: some View {
        
        Button(action: action, label: {
            VStack(alignment: alignment, spacing: 4){
                if let systemName = systemName {
                    Image(systemName: systemName)
                        .font(.body)
                        .foregroundColor(!isDisable ? foregroundColor : foregroundColor.opacity(0.2))
                }
                if let textButton = textButton {
                    Text(textButton)
                        .font(.caption)
                        .foregroundColor(!isDisable ? foregroundColor : foregroundColor.opacity(0.2))
                }
            }
            .padding()
        })
        .disabled(isDisable)
        
    }
}

struct VStackButtonActionView_Previews: PreviewProvider {
    static var previews: some View {
        VStackButtonActionView(systemName: .constant("map"), textButton: .constant("Map"), foregroundColor: .constant(.primary),isDisable: .constant(true)) {
            
        }
    }
}
