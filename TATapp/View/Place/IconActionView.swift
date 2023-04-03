//
//  IconActionView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-03.
//

import SwiftUI

struct IconActionView: View {
    @State var systemName: String
    @State var text: String = "test"
    @Binding var isActive: Bool
    
    var action: () -> Void
    
    var body: some View {
        
        Button(action: {}, label: {
            VStack(spacing: 8){
                Image(systemName: systemName)
                    .font(.title3)
                Text(text)
                    .fontWeight(.semibold)
                    .font(.caption)
            }
            .padding(.horizontal)
        })
        .foregroundColor(.black)
        
        
    }
}
