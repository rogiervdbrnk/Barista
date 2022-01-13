//
//  ScanViewModel.swift
//  Barista
//
//  Created by Rogier van den Brink on 10/01/2022.
//

import SwiftUI
import Combine

class ScanViewModel: ObservableObject {
    @Published var coffee: Coffee?
    @Inject var networkSession: NetworkSession
        
    let title = Localizable.scanTitle.localized
    let subtitle = Localizable.scanSubtitle.localized
    
    var coffeeFetcher: CoffeeFetchable?
            
    private let router: Router
    private var disposables = Set<AnyCancellable>()
    
    init(router: Router,
         scheduler: DispatchQueue = DispatchQueue(label: String(describing: ScanViewModel.self))
    ) {
        self.router = router
        self.coffeeFetcher = self
        
        self.fetchCoffee()
    }
    
    func fetchCoffee() {
        coffeeFetcher?.coffeeRequest()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure(let error):
                        self.coffee = nil
                        print("error: \(error.localizedDescription)")
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] coffee in
                    guard let self = self else { return }
                    self.coffee = coffee
                })
            .store(in: &disposables)
    }
    
    deinit {
        disposables.forEach { $0.cancel() }
    }
}

// MARK: - Network request
extension ScanViewModel: CoffeeFetchable {
    func coffeeRequest() -> AnyPublisher<Coffee, CoffeeError> {
        networkSession.request(with: Endpoints.coffee.url)
    }
}

// MARK: - Navigation destination
extension ScanViewModel: Navigationable {
    func navigateToStyles() -> StylesView? {
        router.navigateToStyles(with: coffee,
                                overview: Overview(),
                                and: nil)
    }
}
