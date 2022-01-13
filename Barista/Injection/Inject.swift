//
//  Inject.swift
//  Barista
//
//  Created by Rogier van den Brink on 11/01/2022.
//

import Foundation

@propertyWrapper
struct Inject<Value> {
    let name: String?
    
    // Injectable using lazy initialization, because instead cycle dependencies will crash in init.
    typealias LazyInject = () -> Value
    
    var object: Value?
    var lazy: LazyInject?
    
    public init(name: String? = nil) {
    
        let lazy: LazyInject = {
            DependencyContainer.shared.resolve(name: name)
        }
        self.lazy = lazy
        self.name = name
    }
    
    public var wrappedValue: Value {
        mutating get {
            if let value = object {
                return value
            } else if let lazy = self.lazy {
                let v = lazy()
                object = v
                
                return v
            } else {
                fatalError("Initialization of dependency failed")
            }
        }
        set {
            object = newValue
        }
    }
}
