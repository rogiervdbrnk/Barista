//
//  Coffee.swift
//  Barista
//
//  Created by Rogier van den Brink on 10/01/2022.
//

import Foundation

// MARK: - Coffee
struct Coffee: Codable {
    let id: String
    let types: [CoffeeStyle]
    let sizes: [Size]
    let extras: [Extra]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case types, sizes, extras
    }
}
