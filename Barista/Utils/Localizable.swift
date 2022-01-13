//
//  Localizable.swift
//  Barista
//
//  Created by Rogier van den Brink on 10/01/2022.
//

import Foundation

enum Localizable: String {
    case scanTitle = "scan_title"
    case scanSubtitle = "scan_subtitle"
    case explanationTitle = "explanation_title"
    case appTitle = "app_title"
    case styleSubtitle = "style_subtitle"
    case sizeTitle = "size_title"
    case extrasTitle = "extras_title"
    case overviewTitle = "overview_title"
    case overviewButtonTitle = "overview_button_title"
    case loadingStyles = "loading_message_styles"
    case loadingSizes = "loading_message_sizes"
    case loadingExtras = "loading_message_extras"
    case continueTitle = "continue_title"
    case editTitle = "edit_title"
    case confirmationTitle = "confirmation_title"
    case confirmationMessage = "confirmation_message"
    case okText = "ok_text"
}

extension Localizable {
    var localized: String {
        return NSLocalizedString(rawValue, comment: "")
    }
}
