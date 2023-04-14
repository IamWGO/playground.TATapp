//
//  PlaceSearchModel.swift
//  tourismthailand
//
//  Created by Waleerat Gottlieb on 2023-03-26.
//

import SwiftUI
import MapKit

struct PlaceSearchModel: Codable {
    let result: [PlaceSearchItem]
}

struct PlaceSearchItem: Codable,Identifiable,Equatable {
    static func == (lhs: PlaceSearchItem, rhs: PlaceSearchItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    let placeId: String
    let placeName: String
    let latitude: Double?
    let longitude: Double?
    let categoryCode: String
    let categoryDescription: String?
    let sha: SHA
    let location: Location
    let thumbnailUrl: String
    let destination: String?
    let tags: [String]?
    let distance: Double?
    let updateDate: String?
    
    private enum CodingKeys: String, CodingKey {
        case placeId = "place_id"
        case placeName = "place_name"
        case latitude, longitude
        case categoryCode = "category_code"
        case categoryDescription = "category_description"
        case sha, location
        case thumbnailUrl = "thumbnail_url"
        case destination, tags, distance
        case updateDate = "update_date"
    }
    
    var id: String {
        placeId
    }
    
    var mapRegion: MKCoordinateRegion {
        MKCoordinateRegion(center: getCoordinate(), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
    }
    
    func isHasLocation() -> Bool {
        return (latitude != nil && longitude != nil)
    }
    
    func getCoordinate() -> CLLocationCoordinate2D {
        if let latitude = latitude, let longitude = longitude {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            return CLLocationCoordinate2D(latitude: kDefaultLocation.latitude, longitude: kDefaultLocation.longitude)
        }
    } 
    
    func getPlaceTypeColor() -> Color {
        switch(categoryCode) {
        case "OTHER":  return Color.Placetype.other
        case "SHOP":  return Color.Placetype.shopping
        case "RESTAURANT":  return Color.Placetype.restaurant
        case "ACCOMMODATION":  return Color.Placetype.accommodation
        case "ATTRACTION":  return Color.Placetype.attraction
        default: return Color.theme.button
        }
        
    }
    
    func getFullAddress() -> String {
        var address = ""
        if (location.address != "") { address +=  "\(location.address) " }
        if (location.subDistrict != "") { address +=  "\(location.subDistrict) " }
        if (location.district != "") { address +=  "\(location.district) " }
        if (location.province != "") { address +=  "\(location.province) " }
        if (location.postcode != "") { address +=  "\(location.postcode) " }
        
        return address
    }
    
    func getDistrictAndProvince() -> String {
        var address = ""
        if (location.district != "") { address +=  "\(location.district) " }
        if (location.province != "") { address +=  "\(location.province) " }
        return address
    }
    
    func getShaTypeDescription() -> String {
        return "\(sha.shaTypeDescription)"
    }
  
}
