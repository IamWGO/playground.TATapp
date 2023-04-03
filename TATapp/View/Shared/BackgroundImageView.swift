//
//  BackgroundImageView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-07.
//

import SwiftUI

struct BackgroundImageView: View {
    @State var imageName: String = "landing-background"
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .overlay {
                Color.white.opacity(0.9)
            }
    }
}

struct BackgroundImageView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImageView()
    }
}
