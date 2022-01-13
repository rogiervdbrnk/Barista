//
//  CoffeeButton.swift
//  Barista
//
//  Created by Rogier van den Brink on 12/01/2022.
//

import SwiftUI

struct CoffeeButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.secondaryBackgroundColor)
            .foregroundColor(.white)
            .cornerRadius(DefaultViewTraits.backgroundCornerRadius)
            .font(.cardFont)
    }
}
