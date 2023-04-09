//
//  SelectionLanguageView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-08.
//

import Foundation
import SwiftUI

struct SelectionLanguageView: View {
    @EnvironmentObject var mainVM: MainViewModel
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 20){
                Spacer()
                Text("Select Language")
                    .modifier(TextModifier(fontStyle: .header))
                    .padding(.bottom, 20)
                
                LargeButtonActionView(textButton: "ภาษาไทย") {
                    mainVM.setLanguage(language: "TH")
                }
                
                LargeButtonActionView(textButton: "English") {
                    mainVM.setLanguage(language: "EN")
                }
                Spacer()
            }
        }
        .background(BackgroundImageView())
        .ignoresSafeArea()
    }
}

struct SelectionLanguageView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionLanguageView()
    }
}

struct LargeButtonActionView: View {
    @State var textButton: String
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text(textButton)
                .modifier(TextModifier(fontStyle: .title, foregroundColor: Color.white))
                .padding(15)
                .frame(width: isIpad ? 300 : 200)
                .background(Color.theme.button)
                .cornerRadius(10)
                .shadow(
                    color: Color.theme.primary.opacity(0.25),
                    radius: 10, x: 0, y: 0)
        })
    }
}
