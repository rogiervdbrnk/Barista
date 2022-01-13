//
//  ExtrasViewModel.swift
//  Barista
//
//  Created by Rogier van den Brink on 11/01/2022.
//

import SwiftUI
import Combine

class ExtrasViewModel: ObservableObject {
    @Published var coffee: Coffee?
    @Published var extras: [Extra]?
    @Published var selectedOverview: Overview
    @Published var rowViewModels: [ExtraRowViewModel]?
    
    @Published var selection: Set<ExtraRowViewModel> = []
    
    private var disposables = Set<AnyCancellable>()
        
    let title = Localizable.appTitle.localized
    let subtitle = Localizable.extrasTitle.localized
            
    private let router: Router
    
    init(router: Router, selectedOverview: Overview) {
        self.router = router
        self.selectedOverview = selectedOverview
        
        $extras
            .sink(receiveValue: { [weak self] value in
                self?.rowViewModels = value?.compactMap { ExtraRowViewModel(item: $0) } ?? []
            })
            .store(in: &disposables)
    }
    
    // MARK: - Selection for collapsing row
    func selectDeselect(_ extra: ExtraRowViewModel) {
        if selection.contains(extra) {
            selection.remove(extra)
        } else {
            selection.insert(extra)
        }
    }
    
    deinit {
        disposables.forEach { $0.cancel() }
    }
}

// MARK: - Navigation destination
extension ExtrasViewModel: Navigationable {
    
    func navigateToOverview() -> OverviewView? {
        router.navigateToOverview(with: coffee,
                                  overview: selectedOverview,
                                  and: nil)
    }
}

// MARK: - Save selection
extension ExtrasViewModel: Selectable {
    func selectOption(key: String, value: Any) {
        if let row = value as? ExtraRowViewModel {
            selectedOverview[key] = row.model
        } else if let row = value as? Subselection {
            selectedOverview[key] = row
        }
    }
}
