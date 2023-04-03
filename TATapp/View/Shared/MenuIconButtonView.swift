//
//  MenuIconButtonView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-07.
//

import SwiftUI

struct MenuIconButtonView: View {
    @Binding var isShowMenu: Bool
    
    var body: some View {
        VStack {
            Button {
                isShowMenu.toggle()
            } label: {
                Image(systemName: "text.justify")
                    .font(.body)
                    .foregroundColor(Color.theme.primary)
                    .padding(10)
                    .rotationEffect(Angle(degrees: isShowMenu ? 180 : 0))
            }
        }
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
}

struct MenuIconButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MenuIconButtonView(isShowMenu: .constant(false))
    }
}
 
