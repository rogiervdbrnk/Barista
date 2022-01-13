//
//  BaristaApp.swift
//  Barista
//
//  Created by Rogier van den Brink on 10/01/2022.
//

import SwiftUI

@main
struct BaristaApp: App {
    
    init() {
        DependencyContainer.shared.setupDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            let router = Router()
            router.navigateToScanView()
        }
    }
}
