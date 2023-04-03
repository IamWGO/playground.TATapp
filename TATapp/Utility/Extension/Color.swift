//
//  Color.swift
//  SwiftfulCrypto
//
//  Created by Nick Sarno on 5/8/21.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = GreenTheme()
    static let launch = LaunchTheme()
    
    /**
     Convert Hex color to UIColor
     - Parameters:
        - hex: #E5E5E5
     - Returns: UIColor
     */
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct GreenTheme {
    let background = Color(hex: "FFFFFF")
    let button = Color(hex: "1FB18D")
    let buttonText = Color(hex: "FFFFFF")
    let hilightText = Color(hex: "1FB18D")
    let primary = Color(hex: "464B4E")
    let card = Color(hex: "D4D7D9")
    let active = Color(hex: "1FB18D")
    let inactive = Color(hex: "464B4E")
}

struct OrangeTheme {
    let background = Color(hex: "FFFFFF")
    let button = Color(hex: "FF7122")
    let buttonText = Color(hex: "FFFFFF")
    let hilightText = Color(hex: "FF7122")
    let primary = Color(hex: "464B4E")
    let card = Color(hex: "D4D7D9")
    let active = Color(hex: "FF6000")
    let inactive = Color(hex: "464B4E")
}

struct LaunchTheme {
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
    
}

struct ColorSpot {
    static let attraction = Color(hex: "FD9D6F")
    static let shopping = Color(hex: "C053EB")
    static let restaurant = Color(hex: "1F639B")
    static let accommodation = Color(hex: "CE5959")
    static let other = Color(hex: "FAE14E")
    static let event = Color(hex: "77037B")
}
