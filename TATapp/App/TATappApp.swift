//
//  TATappApp.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-03.
//

import SwiftUI
import Firebase

@main
struct TATappApp: App {
    @StateObject private var mainVM = MainViewModel()
    
    
    @State private var showLaunchView: Bool = true
   
    init() {
        setupFirebaseApp()
        setNavBar()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mainVM)
        }
    }
    
    private func setNavBar() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.primary)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.primary)]
        UINavigationBar.appearance().tintColor = UIColor(Color.theme.primary)
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    private func setupFirebaseApp() {
       guard let plistPath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
                      let options =  FirebaseOptions(contentsOfFile: plistPath)
                      else { return }
                  if FirebaseApp.app() == nil{
                      FirebaseApp.configure(options: options)
                  }
    
    }
}
