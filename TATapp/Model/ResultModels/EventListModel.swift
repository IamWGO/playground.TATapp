//
//  EventListModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-04.
//

import Foundation
import MapKit

struct EventListModel: Codable {
    let result: [EventItem]
}

struct EventItem: Codable {
    let eventId: String
    let eventName: String
    let latitude: Double?
    let longitude: Double?
    let displayEventPeriodDate: String
    let eventStartDate: String
    let eventEndDate: String
    let eventIntroduction: String
    let thumbnailUrl: URL
    let distance: Double
    let destination: String
    let tags: [String]?
    let location: String
    let updateDate: String?
    
    enum CodingKeys: String, CodingKey {
        case eventId = "event_id"
        case eventName = "event_name"
        case latitude
        case longitude
        case displayEventPeriodDate = "display_event_period_date"
        case eventStartDate = "event_start_date"
        case eventEndDate = "event_end_date"
        case eventIntroduction = "event_introduction"
        case thumbnailUrl = "thumbnail_url"
        case distance
        case destination
        case tags
        case location
        case updateDate = "update_date"
    }
    
    var id: String {
        eventId
    }
    
    var coordinates: CLLocationCoordinate2D? {
        if let latitude = latitude, let longitude = longitude {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            return nil
        }
    }
}


struct EventDetailModel: Codable {
    let result: EventDetail
}

struct EventDetail: Codable {
    let eventId: String
    let eventName: String
    let latitude: Double?
    let longitude: Double?
    let displayEventPeriodDate: String
    let eventStartDate: String
    let eventEndDate: String
    let eventInformation: EventInformation
    let contact: Contact
    let webPictureUrls: [String]
    let mobilePictureUrls: [String]
    let destination: String
    let tags: [String]?
    let location: String
    let updateDate: String
    
    enum CodingKeys: String, CodingKey {
        case eventId = "event_id"
        case eventName = "event_name"
        case latitude
        case longitude
        case displayEventPeriodDate = "display_event_period_date"
        case eventStartDate = "event_start_date"
        case eventEndDate = "event_end_date"
        case eventInformation = "event_information"
        case contact
        case webPictureUrls = "web_picture_urls"
        case mobilePictureUrls = "mobile_picture_urls"
        case destination
        case tags
        case location
        case updateDate = "update_date"
    }
    
    struct EventInformation: Codable {
        let eventIntroduction: String
        let eventHtmlDetail: String
        let eventTypes: [EventType]
        
        enum CodingKeys: String, CodingKey {
            case eventIntroduction = "event_introduction"
            case eventHtmlDetail = "event_html_detail"
            case eventTypes = "event_types"
        }
    }

    struct EventType: Codable {
        let code: String
        let description: String
    }

    struct Contact: Codable {
        let phones: [String]
        let emails: [String]?
        let urls: [String]?
    }
}


