//
//  BaristaTests.swift
//  BaristaTests
//
//  Created by Rogier van den Brink on 10/01/2022.
//

import XCTest
import Combine
@testable import Barista

class BaristaTests: XCTestCase {
    
    var sut: ScanViewModel?
    let router = Router()
    private var cancellables: Set<AnyCancellable>!
    
    class CoffeeFetcherMock: CoffeeFetchable {
        let mockCoffee = Coffee(id: "60ba1ab72e35f2d9c786c610",
                                types: [
                                    CoffeeStyle(id: "60ba1a062e35f2d9c786c56d",
                                                name: "Ristretto",
                                                sizes: [
                                                    "60ba18d13ca8c43196b5f606",
                                                    "60ba3368c45ecee5d77a016b"
                                                ], extras: [
                                                    "60ba197c2e35f2d9c786c525"
                                                ])
                                ],
                                sizes: [
                                    Size(id: "60ba18d13ca8c43196b5f606",
                                         name: "Large",
                                         v: 0)
                                ],
                                extras: [
                                    Extra(id: "60ba197c2e35f2d9c786c525",
                                          name: "Select the amount of sugar",
                                          subselections: [
                                            Subselection(id: "60ba194dfdd5e192e14eaa75",
                                                         name: "A lot")
                                          ])
                                ])
        
        func coffeeRequest() -> AnyPublisher<Coffee, CoffeeError> {
            return Just(mockCoffee)
                        .setFailureType(to: CoffeeError.self)
                        .eraseToAnyPublisher()
        }
    }

    override func setUpWithError() throws {
        sut = ScanViewModel(router: router)
        cancellables = []
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testCoffeeFetcher() throws {
        var coffee: Coffee?
        var error: CoffeeError?
        let expectation = self.expectation(description: "Coffee fetcher")
        // Given
        
        sut?.coffeeFetcher = CoffeeFetcherMock()
        
        // When
        sut?.coffeeFetcher?.coffeeRequest()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }

                expectation.fulfill()
            }, receiveValue: { value in
                coffee = value
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 10)

        // Then
        XCTAssertNil(error)
        XCTAssertEqual(coffee?.types.first?.name, "Ristretto")
        XCTAssertEqual(coffee?.sizes.first?.name, "Large")
        XCTAssertEqual(coffee?.extras.first?.id, "60ba197c2e35f2d9c786c525")
    }

}
