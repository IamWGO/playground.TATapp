//
//  LocationModel.swift
//  tourismthailand
//
//  Created by Waleerat Gottlieb on 2023-03-27.
//

import Foundation

struct LocationModel: Codable {
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
