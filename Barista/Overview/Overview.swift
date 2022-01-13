//
//  Overview.swift
//  Barista
//
//  Created by Rogier van den Brink on 11/01/2022.
//

import Foundation

// MARK: - Overview
typealias Overview = [String: Any]

// MARK: - OverviewRowViewModel
struct OverviewRowViewModel {
    let id = UUID()
    let name: String?
    let image: String?
    let isSubselection: Bool
    let type: CoffeeScreen
}

extension OverviewRowViewModel: Equatable { }
