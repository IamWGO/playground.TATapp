//
//  Location.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-04.
//

import Foundation

struct Location: Codable {
    let address: String
    let subDistrict: String
    let district: String
    let province: String
    let postcode: String
    
    private enum CodingKeys: String, CodingKey {
        case address, subDistrict = "sub_district"
        case district, province, postcode
    }
}
 
