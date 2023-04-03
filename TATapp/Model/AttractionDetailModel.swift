//
//  AttractionDetailModel.swift
//  tourismthailand
//
//  Created by Waleerat Gottlieb on 2023-03-27.
//

import Foundation
 
struct AttractionDetailModel: Codable {
    let result: PlaceDetails
}

struct PlaceDetails: Codable {
    let placeId: String
    let placeName: String
    let latitude: Double
    let longitude: Double
    let mapCode: String
    let sha: ShaDetails
    let placeInformation: PlaceInformationDetails
    let location: LocationDetails
    let contact: ContactDetails
    let thumbnailUrl: String
    let webPictureUrls: [String]
    let mobilePictureUrls: [String]
    let facilities: [String]?
    let services: [String]?
    let paymentMethods: [String]?
    let howToTravel: String
    let openingHours: OpeningHoursDetails
}

struct ShaDetails: Codable {
    let shaName: String
    let shaTypeCode: String
    let shaTypeDescription: String
    let shaCateId: String
    let shaCateDescription: String
}

struct PlaceInformationDetails: Codable {
    let introduction: String
    let detail: String
    let attractionTypes: [AttractionTypeDetails]
    let activities: [String]?
    let fee: FeeDetails
    let targets: [String]?
}

struct AttractionTypeDetails: Codable {
    let code: String
    let description: String
}

struct FeeDetails: Codable {
    let thaiChild: String
    let thaiAdult: String
    let foreignerChild: String
    let foreignerAdult: String
}

struct LocationDetails: Codable {
    let address: String
    let subDistrict: String
    let district: String
    let province: String
    let postcode: String
}

struct ContactDetails: Codable {
    let phones: [String]?
    let mobiles: [String]?
    let fax: [String]?
    let emails: [String]?
    let urls: [String]?
}

struct OpeningHoursDetails: Codable {
    let openNow: Bool
    let periods: [PeriodDetails]
    let weekdayText: WeekdayTextDetails
}

struct PeriodDetails: Codable {
    let open: DayTimeDetails
    let close: DayTimeDetails
}

struct DayTimeDetails: Codable {
    let day: Int
    let time: String
}

struct WeekdayTextDetails: Codable {
    let day1: DayTimeTextDetails
    let day2: DayTimeTextDetails
    let day3: DayTimeTextDetails
    let day4: DayTimeTextDetails
    let day5: DayTimeTextDetails
    let day6: DayTimeTextDetails
    let day7: DayTimeTextDetails
}

struct DayTimeTextDetails: Codable {
    let day: String
    let time: String
}
