//
//  DependencyContainer.swift
//  Barista
//
//  Created by Rogier van den Brink on 11/01/2022.
//

import Foundation

class DependencyContainer {
    static let shared = DependencyContainer()
    private var dependencies = [DependencyObject]()
    private var singletons = [AnyObject]()
    
    /// Registers a dependency in the container.
    ///
    /// - Parameters:
    ///     - initialize: Closure to initializer the object.
    ///     - type: The type the object is registered for, this could be
    ///             a protocol or class.
    ///     - lifecycle: Could be either `.transient` or `.singleton`.
    ///     - name: Use an name to register the dependency instead of the type.
    private func register<T, U>(_ initialize: @escaping () -> T, _ type: U.Type, lifecycle: DependencyLifecycle, name: String?) {
        let object = DependencyObject(initClosure: initialize, type, lifecycle: lifecycle, name: name)
        
        if lifecycle != .singleton {
            dependencies.append(object)
            return
        }
        
        // Replace singleton if it is added twice
        if let index = dependencies.firstIndex(where: { $0.identifier == ObjectIdentifier(U.self) }) {
            dependencies[index] = object
            singletons.removeAll(where: { $0 is T })
        } else {
            dependencies.append(object)
        }
        
        guard let singleton = object.initClosure() as? U else {
            fatalError("Couldn't initialize singleton for type: \(U.self)")
        }
        
        singletons.append(singleton as AnyObject)
    }
    
    /// Register a dependency as a transient, which means they're created each time when requested from the dependency container.
    ///
    /// - Parameters:
    ///     - initialize: Closure to initializer the object.
    ///     - type: The type the object is registered for, this could be
    ///             a protocol or class.
    ///     - name: Use an name to register the dependency instead of the type.
    public func addTransient<T, U>(_ initialize: @escaping () -> T, _ type: U.Type, name: String? = nil) {
        register(initialize, type, lifecycle: .transient, name: name)
    }
    
    /// Register a dependency as a singleton with the dependency container.
    ///
    /// - Parameters:
    ///     - initialize: Closure to initializer the object.
    ///     - type: The type the object is registered for, this could be
    ///             a protocol or class.
    public func addSingleton<T, U>(_ initialize: @escaping () -> T, _ type: U.Type) {
        register(initialize, type, lifecycle: .singleton, name: nil)
    }
    
    /// Fetches a dependency based on its registered type. Depending on the lifecycle
    /// a dependency is created everytime when injected (`.transient`), or once per app (`.singleton`).
    ///
    /// - Parameters:
    ///     - name: Fetches a dependency by name if it's registered with a name.
    ///
    /// - Returns: Returns a dep.
    public func resolve<T>(name: String? = nil) -> T {
        var result: DependencyObject?
        
        if let n = name {
            result = dependencies.first { $0.name?.lowercased() == n.lowercased() }
        } else {
            result = dependencies.first { $0.identifier == ObjectIdentifier(T.self) }
        }
        
        guard let dependencyObject = result else {
            fatalError("No dependency registered for type: \(T.self)")
        }
        
        switch dependencyObject.lifecycle {
        case .transient:
            guard let dependencyInstance = dependencyObject.initClosure() as? T else {
                fatalError("Couldn't initialize type: \(T.self)")
            }
            
            return dependencyInstance
        case .singleton:
            guard let singleton = singletons.first(where: { $0 is T }) as? T else {
                fatalError("Couldn't find singleton for type: \(T.self)")
            }
            
            return singleton
        }
    }
    
    /// Fetches all dependencies that are using the same ObjectIdentifier. After that it
    /// will initialize them all.
    ///
    /// - Returns: Returns an array of all initialized dependencies.
    public func resolveAll<T: Sequence>() -> T {
        let result = dependencies.filter { $0.identifier == ObjectIdentifier(T.Element.self) }
        
        let initializedObjects = result.compactMap { object -> T.Element? in
            return object.initClosure() as? T.Element
        }
        
        guard let objects = initializedObjects as? T else {
            fatalError("Couldn't map objects to Array type of: \(T.Element.self)")
        }
        
        return objects
    }
    
    /// Clears all dependencies from the container, this is only used for unit testing.
    func reset() {
        dependencies = [DependencyObject]()
        singletons = [AnyObject]()
    }
}


extension DependencyContainer {
    public func setupDependencies() {
        
        addSingleton({ () -> NetworkManager in
            NetworkManager()}, NetworkSession.self)
    }
}
