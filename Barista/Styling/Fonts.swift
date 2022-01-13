//
//  Fonts.swift
//  Barista
//
//  Created by Rogier van den Brink on 10/01/2022.
//

import Foundation
import SwiftUI

extension Font {
    static let boldTitleFont = Font.custom(CoffeeFont.bold.rawValue, size: 16)
    static let largeTitleFont = Font.custom(CoffeeFont.regular.rawValue, size: 24)
    static let linkFont = Font.custom(CoffeeFont.regular.rawValue, size: 16)
    static let cardFont = Font.custom(CoffeeFont.demibold.rawValue, size: 14)
}

enum CoffeeFont: String {
    case bold = "AvenirNext-Bold"
    case demibold = "AvenirNext-DemiBold"
    case medium = "AvenirNext-Medium"
    case ultralight = "AvenirNext-UltraLight"
    case heavy = "AvenirNext-Heavy"
    case regular = "AvenirNext-Regular"
    case black = "Avenir-Black"
}
