//
//  SizeRowViewModel.swift
//  Barista
//
//  Created by Rogier van den Brink on 11/01/2022.
//

import Foundation

struct SizeRowViewModel: BaseRowViewModel {
    typealias Item = Size
    
    private let item: Item
    
    var id: String {
        String(item.id)
    }
    
    var title: String {
        item.name
    }
    
    var image: String? {
        AssetName(rawValue: item.name)?.rawValue
    }
    
    var model: Size {
        item
    }
    
    init(item: Item) {
        self.item = item
    }
}
