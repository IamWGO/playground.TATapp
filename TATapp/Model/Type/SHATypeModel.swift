//
//  SHATypeModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-06.
//

import SwiftUI

enum SHAType: String {
    case ALL // All Types,
    case SHOP // Department store And shopping centers,
    case RESTAURANT // Restaurants / diners,
    case ACCOMMODATION // Hotel / accommodation and meeting place,
    case ATTRACTION // Recreational activity and tourist attraction,
    case TRANSPORTATION // Transportation,
    case TRAVEL_AGENCY // Travel agency,
    case HEALTH_BEAUTY // Health and Beauty,
    case SPORT // Sport for tourism,
    case ACTIVITY_ENTERTAINMENT // Activity/meeting, Theater/entertainment,
    case SOUVENIR // Souvenir shop and other shops
    
    var value: String {
        return self.rawValue
    }
}

enum SHAcategoriy: String {
    case ALL //All Types,
    case SHA //SHA,
    case SHA_PLUS //SHA Plus,
    case SHA_EXTRA_PLUS //SHA Extra+
    
    var value: String {
        return self.rawValue
    }
}
