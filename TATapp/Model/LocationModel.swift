//
//  LocationModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-08.
//

import SwiftUI
import MapKit

struct LocationCoordinate: Identifiable, Equatable {
    let placeId: String
    let placeName: String
    let shortAddress: String
    let coordinates: CLLocationCoordinate2D
    let shotDescription: String
    let imageNames: String?
   
    
    // Identifiable
    var id: String {
       placeId
    }
    
    static func == (lhs: LocationCoordinate, rhs: LocationCoordinate) -> Bool {
        lhs.id == rhs.id
    }

}
