//
//  Extra.swift
//  Barista
//
//  Created by Rogier van den Brink on 10/01/2022.
//

import Foundation

// MARK: - Extra
struct Extra: Codable {
    let id, name: String
    let subselections: [Subselection]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, subselections
    }
}

// MARK: - Subselection
struct Subselection: Codable {
    let id, name: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
    }
}

extension Extra: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Extra, rhs: Extra) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}
