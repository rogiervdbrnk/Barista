//
//  StyleRowViewModel.swift
//  Barista
//
//  Created by Rogier van den Brink on 11/01/2022.
//

import Foundation

protocol BaseRowViewModel {
    associatedtype Item
    
    var id: String { get }
    var title: String { get }
    var image: String? { get }
    var model: Item { get }
    
    init(item: Item)
}

struct StyleRowViewModel: BaseRowViewModel {
    typealias Item = CoffeeStyle
    
    private let item: Item
    
    var id: String {
        item.id
    }
    
    var title: String {
        item.name
    }
    
    var image: String? {
        AssetName(rawValue: item.name)?.rawValue
    }
    
    var model: CoffeeStyle {
        item
    }
    
    init(item: Item) {
        self.item = item
    }
}

