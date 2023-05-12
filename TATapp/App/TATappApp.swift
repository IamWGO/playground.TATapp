//
//  TATappApp.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-03.
//

import SwiftUI

@main
struct TATappApp: App {
    @StateObject private var mainVM = MainViewModel()
    
    @State private var showLaunchView: Bool = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.primary)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.primary)]
        UINavigationBar.appearance().tintColor = UIColor(Color.theme.primary)
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mainVM)
        }
    }
}
