//
//  TopAreaIconActionView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-07.
//

import SwiftUI

struct TopAreaIconActionView: View {
    var systemName: String = "chevron.backward"
    var action: () -> Void
    var body: some View {
        
        Button(action: action, label: {
            Image(systemName: systemName)
                .font(.body)
                .foregroundColor(Color.theme.primary)
                .padding(15)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        })
    }
}

struct TopAreaIconActionView_Previews: PreviewProvider {
    static var previews: some View {
        TopAreaIconActionView() {}
    }
}
