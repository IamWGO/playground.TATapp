//
//  Contact.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-04.
//

import Foundation

struct ContactInfo: Codable {
    let phones: [String]?
    let mobiles: [String]?
    let fax: String?
    let emails: [String]?
    let urls: [String]?

    enum CodingKeys: String, CodingKey {
        case phones, mobiles, fax, emails, urls
    }
}


 
