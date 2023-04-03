//
//  ContentView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-03.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var mainVM: MainViewModel
    var body: some View {
        LandingPageView(mainVM: mainVM)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
