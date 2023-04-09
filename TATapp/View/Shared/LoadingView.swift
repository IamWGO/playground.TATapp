//
//  LoadingView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-09.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack{
            Color.theme.primary.opacity(0.4)
            Image(systemName: "slowmo")
                .font(.largeTitle)
                .padding(50)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
        }
        
        
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
