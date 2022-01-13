//
//  Selectable.swift
//  Barista
//
//  Created by Rogier van den Brink on 11/01/2022.
//

import Foundation

protocol Selectable {
    func selectOption(key: String, value: Any)
}

enum CoffeeOverviewKey: String {
    case scan
    case style
    case size
    case extra
    case subselection
    case overview
}
