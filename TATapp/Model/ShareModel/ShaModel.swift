//
//  ShaModel.swift
//  tourismthailand
//
//  Created by Waleerat Gottlieb on 2023-03-27.
//

import Foundation

struct ShaModel: Codable {
    let shaName: String
    let shaTypeCode: String
    let shaTypeDescription: String
    let shaCateId: String
    let shaCateDescription: String
    
    private enum CodingKeys: String, CodingKey {
        case shaName = "sha_name"
        case shaTypeCode = "sha_type_code"
        case shaTypeDescription = "sha_type_description"
        case shaCateId = "sha_cate_id"
        case shaCateDescription = "sha_cate_description"
    }
}
