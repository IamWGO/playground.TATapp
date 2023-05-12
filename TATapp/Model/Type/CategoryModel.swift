//
//  UIModels.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-05.
//

import SwiftUI

enum PlaceSearchType: String {
    case ALL //All Category,
    case OTHER //Other Place Type,
    case SHOP //Shopping Type,
    case RESTAURANT //Restaurant Type,
    case ACCOMMODATION //Hotel Type,
    case ATTRACTION //Attraction Type
    case EVENT
    
    var value: String {
        return self.rawValue
    }
    
     
}


struct CategoryModel: Identifiable, Equatable{
    let name: String
    let placeType: PlaceSearchType
    let systemName: String
    let backgroundColor: Color
    let foregroundColor: Color
    
    var id: String {
        name
    }
}


struct Province: Codable, Identifiable, Equatable {
    let provinceNameTh: String
    let provinceNameEn: String
    let provinceCode: String
   
    var id: String {
        provinceCode
    }
}
