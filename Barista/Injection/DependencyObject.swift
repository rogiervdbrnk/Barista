//
//  DependencyObject.swift
//  Barista
//
//  Created by Rogier van den Brink on 11/01/2022.
//

import Foundation

struct DependencyObject {
    var identifier: ObjectIdentifier
    var initClosure: () -> Any
    var lifecycle: DependencyLifecycle
    var name: String?
    
    init<T>(initClosure: @escaping () -> Any, _ type: T.Type, lifecycle: DependencyLifecycle, name: String? = nil) {
        identifier = ObjectIdentifier(type.self)
        self.initClosure = initClosure
        self.lifecycle = lifecycle
        self.name = name
    }
}
