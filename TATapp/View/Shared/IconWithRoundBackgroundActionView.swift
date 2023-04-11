//
//  TopAreaIconActionView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-07.
//

import SwiftUI

struct IconWithRoundBackgroundActionView: View {
    var systemName: String = "chevron.backward"
    var backgroundColor: Color?
    var action: () -> Void
    var body: some View {
        
        Button(action: action, label: {
            Image(systemName: systemName)
                .font(.body)
                .foregroundColor(Color.theme.primary)
                .padding(15)
                .background((backgroundColor != nil) ? backgroundColor?.opacity(0.5) : Color.theme.primary.opacity(0.1))
                .clipShape(Circle())
        })
    }
}

struct TopAreaIconActionView_Previews: PreviewProvider {
    static var previews: some View {
        IconWithRoundBackgroundActionView() {}
    }
}
