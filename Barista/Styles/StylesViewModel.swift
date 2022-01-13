//
//  StylesViewModel.swift
//  Barista
//
//  Created by Rogier van den Brink on 10/01/2022.
//

import SwiftUI
import Combine

class StylesViewModel: ObservableObject {
    @Published var coffee: Coffee?
    @Published var selectedStyle: CoffeeStyle?
    @Published var selectedOverview: Overview
    @Published var rowViewModels: [StyleRowViewModel]?
    
    private var disposables = Set<AnyCancellable>()
        
    let title = Localizable.appTitle.localized
    let subtitle = Localizable.styleSubtitle.localized
            
    private let router: Router
    
    init(router: Router, selectedOverview: Overview) {
        self.router = router
        self.selectedOverview = selectedOverview
        
        $coffee
            .sink(receiveValue: { [weak self] value in
                self?.rowViewModels = value?.types.compactMap { StyleRowViewModel(item: $0) } ?? []
            })
            .store(in: &disposables)
    }
    
    deinit {
        disposables.forEach { $0.cancel() }
    }
}

// MARK: - Navigation destination
extension StylesViewModel: Navigationable {
    func navigateToSizes() -> SizesView? {
        router.navigateToSizes(with: coffee,
                               overview: selectedOverview,
                               and: filterSizesForStyle(style: selectedStyle))
    }
    
    func filterSizesForStyle(style: CoffeeStyle?) -> [Size] {
        guard let style = style,
              let coffee = coffee else { return [] }
        
        let availableSizes = style.sizes.compactMap { $0 }
        
        return coffee.sizes.filter { availableSizes.contains($0.id) }
        
    }
}

// MARK: - Save selection
extension StylesViewModel: Selectable {
    func selectOption(key: String, value: Any) {
        if let row = value as? StyleRowViewModel {
            selectedStyle = row.model
            selectedOverview[key] = row.model
        }
    }
}
