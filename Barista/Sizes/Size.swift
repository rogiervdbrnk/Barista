//
//  Size.swift
//  Barista
//
//  Created by Rogier van den Brink on 10/01/2022.
//

import Foundation

// MARK: - Size
struct Size: Codable {
    let id, name: String
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case v = "__v"
    }
}

extension Size: Hashable { }
