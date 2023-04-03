//
//  LargeTextModifier.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-05.
//

import SwiftUI

 
struct FontModifier1: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: CGFloat
    
    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize))
    }
    
}

struct TextModifier: ViewModifier {
    @State var fontStyle: FontStyle = FontStyle.body
    @State var fontWeight: Font.Weight = .regular
    @State var alignment: TextAlignment = .leading
    @State var isInactive = false
    @State var foregroundColor = Color.theme.primary
    @State var lineLimit:  Int? = nil
    
    func body(content: Content) -> some View {
        content
        .font(.system(size: fontStyle.size ,
                      weight: fontWeight,
                      design: .default))
        .lineLimit(lineLimit)
        .multilineTextAlignment(alignment)
        .foregroundColor(foregroundColor)
        
    }
    
    func getScaledSize(size: CGFloat) -> CGFloat{
        return UIFontMetrics.default.scaledValue(for: size)
    }
    
    
    func getCustomFont(fontWeight: Font.Weight, size: CGFloat) -> Font {
        var fontName = "NotoSerifThai-Regular"
        
        switch (fontWeight) {
        case .heavy : fontName = "NotoSerifThai-ExtraBold"
        case .bold : fontName = "Charmonman-Bold"
        case .medium : fontName = "NotoSerifThai-Medium"
        case .semibold : fontName = "NotoSerifThai-SemiBold"
        case .regular : fontName = "NotoSerifThai-Regular"
        case .thin : fontName = "NotoSerifThai-Thin"
        default : fontName = "NotoSerifThai-Regular"
        }
      
        print(fontName)
        return  Font.custom(fontName, size: size)
    }
}

/// check if Ipad
let isIpad:Bool =  UIDevice.current.model.contains("iPad") ? true : false

enum FontStyle {
    case large
    case header
    case title
    case body
    case caption
    
    var size: CGFloat {
        switch self {
        case .large: return isIpad ? 60 : 45
        case .header:  return isIpad ? 45 : 35
        case .title:  return isIpad ? 35 : 25
        case .body:  return isIpad ? 18 : 16
        case .caption:  return isIpad ? 16 : 14
        }
    }
}


// MARK: - Font
