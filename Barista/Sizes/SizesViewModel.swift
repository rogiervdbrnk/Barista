//
//  SizesViewModel.swift
//  Barista
//
//  Created by Rogier van den Brink on 11/01/2022.
//

import SwiftUI
import Combine

class SizesViewModel: ObservableObject {
    @Published var coffee: Coffee?
    @Published var sizes: [Size]?
    @Published var selectedOverview: Overview
    @Published var rowViewModels: [SizeRowViewModel]?
    
    private var disposables = Set<AnyCancellable>()
        
    let title = Localizable.appTitle.localized
    let subtitle = Localizable.sizeTitle.localized
            
    private let router: Router
    
    init(router: Router, selectedOverview: Overview) {
        self.router = router
        self.selectedOverview = selectedOverview
        
        $sizes
            .sink(receiveValue: { [weak self] value in
                self?.rowViewModels = value?.compactMap { SizeRowViewModel(item: $0) } ?? []
            })
            .store(in: &disposables)
    }
    
    deinit {
        disposables.forEach { $0.cancel() }
    }
}

// MARK: - Navigation destination
extension SizesViewModel: Navigationable {
    
    func navigateToExtras() -> ExtrasView? {
        router.navigateToExtras(with: coffee,
                                overview: selectedOverview,
                                and: filterExtrasForStyle())
    }
    
    func filterExtrasForStyle() -> [Extra] {
        guard let selectedStyle = coffee?
                .types
                .filter({ $0 == (selectedOverview[CoffeeOverviewKey.style.rawValue] as? CoffeeStyle) })
                .first,
              let coffee = coffee else { return [] }
        
        let availableExtras = selectedStyle.extras.compactMap { $0 }
        
        return coffee.extras.filter { availableExtras.contains($0.id) }
        
    }
}

// MARK: - Save selection
extension SizesViewModel: Selectable {
    func selectOption(key: String, value: Any) {
        if let row = value as? SizeRowViewModel {
            selectedOverview[key] = row.model
        }
    }
}

