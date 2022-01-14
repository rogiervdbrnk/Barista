//
//  Router.swift
//  Barista
//
//  Created by Rogier van den Brink on 11/01/2022.
//

import Foundation
import SwiftUI

/// Protocol for the routing and passing data in the app
/// View specific functions to avoid `AnyView` as much as possible for memory
/// - Parameters:
///     - coffee: response from api
///     - overview: object with selected options
///     - data: `Any` data to pass along
///
/// - Returns: Returns a view.
protocol RoutingLogic {
    func navigateToStyles(with coffee: Coffee?, overview: Overview, and data: Any?) -> StylesView?
    func navigateToSizes(with coffee: Coffee?, overview: Overview, and data: Any?) -> SizesView?
    func navigateToExtras(with coffee: Coffee?, overview: Overview, and data: Any?) -> ExtrasView?
    func navigateToOverview(with coffee: Coffee?, overview: Overview, and data: Any?) -> OverviewView?
    func navigateToScanView() -> ScanView?
}

/// Protocol for navigation destination
/// - Returns: Returns a view.
protocol Navigationable {
    func navigateToStyles() -> StylesView?
    func navigateToSizes() -> SizesView?
    func navigateToExtras() -> ExtrasView?
    func navigateToOverview() -> OverviewView?
    func navigateToScanView() -> ScanView?
}

/// Default implementations of protocol
extension Navigationable {
    func navigateToStyles() -> StylesView? { return nil }
    func navigateToSizes() -> SizesView? { return nil }
    func navigateToExtras() -> ExtrasView? { return nil }
    func navigateToOverview() -> OverviewView? { return nil }
    func navigateToScanView() -> ScanView? { return nil }
}

enum CoffeeScreen: Int {
    case scan
    case style
    case size
    case extra
    case overview
}

class Router: RoutingLogic {
    var scanView: ScanView?
    var scanViewModel: ScanViewModel?
    
    var stylesView: StylesView?
    var stylesViewModel: StylesViewModel?
    
    var sizesView: SizesView?
    var sizesViewModel: SizesViewModel?
    
    var extrasView: ExtrasView?
    var extrasViewModel: ExtrasViewModel?
    
    var overviewView: OverviewView?
    var overviewViewModel: OverviewViewModel?
    
    func navigateToStyles(with coffee: Coffee?, overview: Overview, and data: Any?) -> StylesView? {
        stylesViewModel = StylesViewModel(router: self, selectedOverview: [String: Any]())
        
        stylesViewModel?.coffee = coffee
        
        guard let viewModel = stylesViewModel else {
            return nil
        }
        stylesView = StylesView(viewModel: viewModel)
        return stylesView
    }
    
    func navigateToSizes(with coffee: Coffee?, overview: Overview, and data: Any?) -> SizesView? {
        sizesViewModel = SizesViewModel(router: self, selectedOverview: overview)
        sizesViewModel?.coffee = coffee
        
        if let data = data as? [Size] {
            sizesViewModel?.sizes = data
        }
        
        guard let viewModel = sizesViewModel else {
            return nil
        }
        
        sizesView = SizesView(viewModel: viewModel)
        return sizesView
    }
    
    func navigateToExtras(with coffee: Coffee?, overview: Overview, and data: Any?) -> ExtrasView? {
        extrasViewModel = ExtrasViewModel(router: self, selectedOverview: overview)
        extrasViewModel?.coffee = coffee
        
        if let data = data as? [Extra] {
            extrasViewModel?.extras = data
        }
        
        guard let viewModel = extrasViewModel else {
            return nil
        }
        
        extrasView = ExtrasView(viewModel: viewModel)
        return extrasView
    }
    
    func navigateToOverview(with coffee: Coffee?, overview: Overview, and data: Any?) -> OverviewView? {
        overviewViewModel = OverviewViewModel(router: self)
        overviewViewModel?.coffee = coffee
        overviewViewModel?.overview = overview
        
        guard let viewModel = overviewViewModel else {
            return nil
        }
        
        overviewView = OverviewView(viewModel: viewModel)
        return overviewView
    }
    
    func navigateToScanView() -> ScanView? {
        scanViewModel = ScanViewModel(router: self)
        
        guard let viewModel = scanViewModel else {
            return nil
        }
        
        scanView = ScanView(viewModel: viewModel)
        return scanView
    }
}
