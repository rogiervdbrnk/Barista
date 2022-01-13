//
//  CoffeeStyle.swift
//  Barista
//
//  Created by Rogier van den Brink on 10/01/2022.
//

import Foundation

// MARK: - CoffeeStyle
struct CoffeeStyle: Codable {
    let id, name: String
    let sizes, extras: [String]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, sizes, extras
    }
}

extension CoffeeStyle: Equatable {}
