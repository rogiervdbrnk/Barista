//
//  UIColor+Ext.swift
//  Barista
//
//  Created by Rogier van den Brink on 10/01/2022.
//

import UIKit
import SwiftUI

extension Color {
    static let primaryBackgroundColor = Color(UIColor.white)
    static let secondaryBackgroundColor = Color(UIColor(hex: 0xadd7a0))
    static let tertiaryBackgroundColor = Color(UIColor(hex: 0x9bc78b))
    static let iconBackgroundColor = Color(UIColor(hex: 0x209653))
    static let shadowColor = Color(UIColor.darkGray).opacity(DefaultViewTraits.shadowOpacity)
    
    static let primaryFontColor = Color(UIColor.black)
    static let secondaryFontColor = Color(UIColor.white)
}

extension UIColor {
    /// The six-digit hexadecimal representation of color of the form #RRGGBB.
    /// - Parameter hex: Six-digit hexadecimal value.
    /// - Parameter alpha: The opacity value of the color object, specified as a value from 0.0 to 1.0. Alpha values below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0.
    /// - Returns: The color object. The color information represented by this object is in an RGB colorspace.
    convenience init(hex: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex & 0x0000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init?(hexString: String?) {
        guard let hexString = hexString, hexString.hasPrefix("#") else {
            return nil
        }
        
        let start = hexString.index(hexString.startIndex, offsetBy: 1)
        let hexColor = String(hexString[start...])
        
        guard hexColor.count == 6 else {
            return nil
        }
        
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        
        guard scanner.scanHexInt64(&hexNumber) else {
            return nil
        }
        
        let r = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
        let g = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
        let b = CGFloat(hexNumber & 0x000000ff) / 255
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    func hexString(_ includeAlpha: Bool) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        if includeAlpha {
            return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
        } else {
            return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        }
    }
}
