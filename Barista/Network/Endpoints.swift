//
//  Endpoints.swift
//  Barista
//
//  Created by Rogier van den Brink on 10/01/2022.
//

import Foundation
import Combine

enum Endpoints {
    case coffee
    
    static let baseURL = URL(string: "https://darkroastedbeans.coffeeit.nl/coffee-machine/")!
    
    var url: URL {
        switch self {
        case .coffee:
            print(Endpoints.baseURL.appendingPathComponent("60ba1ab72e35f2d9c786c610"))
            return Endpoints.baseURL.appendingPathComponent("60ba1ab72e35f2d9c786c610")
        }
    }
}

protocol CoffeeFetchable {
    func coffeeRequest() -> AnyPublisher<Coffee, CoffeeError>
}
