//
//  UIModels.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-05.
//

import SwiftUI

struct CategoryModel: Identifiable{
    let name: String
    let systemName: String
    let backgroundColor: Color
    let foregroundColor: Color
    
    var id: String {
        name
    }
}

