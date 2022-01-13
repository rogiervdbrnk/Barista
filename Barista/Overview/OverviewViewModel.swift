//
//  OverviewViewModel.swift
//  Barista
//
//  Created by Rogier van den Brink on 11/01/2022.
//

import SwiftUI
import Combine

class OverviewViewModel: ObservableObject {
    @Published var coffee: Coffee?
    @Published var overview: Overview?
    @Published var overviewModels = [OverviewRowViewModel]()
        
    let title = Localizable.appTitle.localized
    let subtitle = Localizable.overviewTitle.localized
    
    private var disposables = Set<AnyCancellable>()
            
    private let router: Router
    
    init(router: Router) {
        self.router = router
        
        $overview
            .sink(receiveValue: { [weak self] value in
                if let overview = value {
                    self?.overviewModels = self?.converToOverviewModel(overview: overview) ?? []
                }
            })
            .store(in: &disposables)
    }
    
    deinit {
        disposables.forEach { $0.cancel() }
    }
}

// MARK: - Navigation destination
extension OverviewViewModel: Navigationable {
    
    func navigateToScanView() -> ScanView? {
        router.navigateToScanView()
    }
    
    func navigateToSizes() -> SizesView? {
        guard let overview = overview,
            let style = overview[CoffeeOverviewKey.style.rawValue] as? CoffeeStyle else { return nil }
        return router.navigateToSizes(with: coffee,
                                      overview: overview,
                                      and: filterSizesForStyle(style: style))
    }
    
    func navigateToStyles() -> StylesView? {
        guard let overview = overview else { return nil }
        return router.navigateToStyles(with: coffee,
                                       overview: overview,
                                       and: nil)
    }
    
    func navigateToExtras() -> ExtrasView? {
        guard let overview = overview,
              let style = overview[CoffeeOverviewKey.style.rawValue] as? CoffeeStyle else { return nil }
        return router.navigateToExtras(with: coffee,
                                       overview: overview,
                                       and: filterExtrasForStyle(style: style))
    }
    
    func filterSizesForStyle(style: CoffeeStyle) -> [Size] {
        let availableSizes = style.sizes.compactMap { $0 }
        
        return coffee?.sizes.filter { availableSizes.contains($0.id) } ?? []
    }
    
    func filterExtrasForStyle(style: CoffeeStyle) -> [Extra] {
        let availableExtras = style.extras.compactMap { $0 }
        
        return coffee?.extras.filter { availableExtras.contains($0.id) } ?? []
    }
    
    func navigateBack(for screen: CoffeeScreen?) -> AnyView? {
        switch screen {
        case .style:
            return AnyView(navigateToStyles())
        case .size:
            return AnyView(navigateToSizes())
        case .extra:
            return AnyView(navigateToExtras())
        default:
            return nil
        }
    }
}

extension OverviewViewModel {
    // MARK: - Helper function for model for views
    func converToOverviewModel(overview: Overview) -> [OverviewRowViewModel] {
        var result = [OverviewRowViewModel]()
        
        if let style = overview[CoffeeOverviewKey.style.rawValue] as? CoffeeStyle {
            let styleModel = OverviewRowViewModel(name: style.name,
                                                  image: AssetName(rawValue: style.name)?.rawValue,
                                                  isSubselection: false,
                                                  type: .style)
            result.append(styleModel)
        }
        
        if let size = overview[CoffeeOverviewKey.size.rawValue] as? Size {
            let sizeModel = OverviewRowViewModel(name: size.name,
                                                 image: AssetName(rawValue: size.name)?.rawValue,
                                                 isSubselection: false,
                                                 type: .size)
            result.append(sizeModel)
        }
        
        if let extra = overview[CoffeeOverviewKey.extra.rawValue] as? Extra {
            let extraModel = OverviewRowViewModel(name: extra.name,
                                                  image: AssetName(rawValue: extra.name)?.rawValue,
                                                  isSubselection: false,
                                                  type: .extra)
            result.append(extraModel)
        }
        
        if let subselection = overview[CoffeeOverviewKey.subselection.rawValue] as? Subselection {
            let subselectionModel = OverviewRowViewModel(name: subselection.name,
                                                         image: AssetName(rawValue: subselection.name)?.rawValue,
                                                         isSubselection: true,
                                                         type: .extra)
            result.append(subselectionModel)
        }
        
        return result
    }
}
