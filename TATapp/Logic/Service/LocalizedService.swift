//
//  LocalizedString.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-05.
//

import Foundation

struct LanguageModel {
    let th: String
    let en: String
}

class LocalizedService {
    static let instance = LocalizedService()
    
    @Published var language: String = "TH"
    @Published var landingString: [String: String] = [:]
    @Published var homeString: [String: String] = [:]
    
    func getText(_ key: String) -> String {
        if let kText = kText[key] {
            return (language.lowercased() == "en") ? kText.en : kText.th
        } else {
            return "."
        }
    }
    
    /// work with struct landingText
    
//    func getLandingString(){
//        let text: [String: LanguageModel] = [
//            "subHeader": LanguageModel(th: "เปิดโลกที่กว้างใหญ่", en: "It's a Big World"),
//            "header": LanguageModel(th: "ประสบการณ์ใหม่", en: "New Experience"),
//            "getStart": LanguageModel(th: "เริ่มใช้งาน", en: "Get Started"),
//            "privicyPolicy": LanguageModel(th: "ข้อกำหนดใช้งาน", en: "Privacy Policy"),
//        ]
//
//        for (key, value) in text {
//            landingString[key] = (language.lowercased() == "en") ? value.en :  value.th
//        }
//    }
//
//    func getHomeString(){
//        let text: [String: LanguageModel] = ["sub-header": LanguageModel(th: "หน้าหลัก", en: "Home Screen")]
//
//        for (key, value) in text {
//            homeString[key] = (language.lowercased() == "en") ? value.en :  value.th
//        }
//    }
     
}
 

struct landingText {
    static var subHeader: String = ""
    static var header:String = ""
    static var getStart: String = ""
    static var privicyPolicy: String = ""
}
