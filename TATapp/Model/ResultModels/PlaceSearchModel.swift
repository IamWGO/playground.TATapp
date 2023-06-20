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
    
    static func structureToDictionary(row: Self) -> [String : Any] {
        
        return NSDictionary(
            objects:
                [row.placeId,
                 row.placeName,
                 row.latitude ?? 0,
                 row.longitude ?? 0,
                 row.categoryCode,
                 row.categoryDescription ?? "",
                 row.sha,
                 row.location,
                 row.thumbnailUrl,
                 row.destination ?? "",
                 row.tags ?? "",
                 row.distance ?? "",
                 row.updateDate ?? "",
                ],
            forKeys: [
                 "placeId" as NSCopying,
                  "placeName" as NSCopying,
                  "latitude" as NSCopying,
                  "longitude" as NSCopying,
                  "categoryCode" as NSCopying,
                  "categoryDescription" as NSCopying,
                  "sha" as NSCopying,
                  "location" as NSCopying,
                  "thumbnailUrl" as NSCopying,
                  "destination" as NSCopying,
                  "tags" as NSCopying,
                  "distance" as NSCopying,
                  "updateDate" as NSCopying,
               
            ]
        ) as! [String : Any]
    }
    
    
    init(
        _placeId: String,
        _placeName: String,
        _latitude: Double?,
        _longitude: Double?,
        _categoryCode: String,
        _categoryDescription: String?,
        _sha: SHA,
        _location: Location,
        _thumbnailUrl: String,
        _destination: String?,
        _tags: [String]?,
        _distance: Double?,
        _updateDate: String?
    ) {
        placeId = _placeId
        placeName = _placeName
        latitude = _latitude
        longitude = _longitude
        categoryCode = _categoryCode
        categoryDescription = _categoryDescription
        sha = _sha
        location = _location
        thumbnailUrl = _thumbnailUrl
        destination = _destination
        tags = _tags
        distance = _distance
        updateDate = _updateDate
    }
    
    static func dictionaryToStructrue(_ row: [String : Any]) -> Self{
        
        return Self(_placeId: row["placeId"] as? String ?? "",
             _placeName: row["placeName"] as? String ?? "",
             _latitude: row["latitude"] as? Double ?? nil,
             _longitude: row["longitude"] as? Double ?? nil,
             _categoryCode: row["categoryCode"] as? String ?? "",
             _categoryDescription: row["categoryDescription"] as? String ?? "",
            _sha: (row["sha"] as? SHA)! ,
            _location: (row["location"] as? Location)! ,
             _thumbnailUrl: row["thumbnailUrl"] as? String ?? "",
             _destination: row["destination"] as? String ?? "",
             _tags: row["tags"] as? [String] ?? nil,
             _distance: row["distance"] as? Double ?? nil,
             _updateDate: row["updateDate"] as? String ?? nil)
        

    }
  
}
