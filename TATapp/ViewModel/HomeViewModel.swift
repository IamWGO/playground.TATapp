//
//  HomeViewModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-03.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    @Published var offset: CGFloat = 0
    
    // Selected Tab....
    @Published var selectedtab = tabsItems.first!.tab 
}
