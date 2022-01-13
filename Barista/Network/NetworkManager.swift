//
//  NetworkManager.swift
//  Barista
//
//  Created by Rogier van den Brink on 12/01/2022.
//

import Foundation
import Combine

class NetworkManager: NetworkSession {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Request
    func request<T>(with url: URL?) -> AnyPublisher<T, CoffeeError> where T: Decodable {
        guard let url = url else {
            let error = CoffeeError.network(message: "No valid URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
            .network(message: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { response in
                self.decodeObject(response.data)
            }
            .eraseToAnyPublisher()
    }
    
    private func decodeObject<T: Decodable>(_ data: Data) -> AnyPublisher<T, CoffeeError> {
        return Just(data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
            .parse(message: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}

protocol NetworkSession: AnyObject {
    func request<T>(with url: URL?) -> AnyPublisher<T, CoffeeError> where T: Decodable
}
