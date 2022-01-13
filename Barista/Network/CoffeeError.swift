//
//  CoffeeError.swift
//  Barista
//
//  Created by Rogier van den Brink on 10/01/2022.
//

import Foundation

enum CoffeeError: Error {
    case network(message: String)
    case parse(message: String)
}
