//
//  ExtraRowViewModel.swift
//  Barista
//
//  Created by Rogier van den Brink on 11/01/2022.
//

import Foundation

struct ExtraRowViewModel: BaseRowViewModel {
    typealias Item = Extra
    
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
    
    var model: Extra {
        item
    }
    
    var subselections: Set<Size> = []
    
    mutating func selectDeselect(_ subselection: Size) {
        if subselections.contains(subselection) {
            subselections.remove(subselection)
        } else {
            subselections.insert(subselection)
        }
    }
    
    init(item: Item) {
        self.item = item
    }
}

extension ExtraRowViewModel: Hashable { }
