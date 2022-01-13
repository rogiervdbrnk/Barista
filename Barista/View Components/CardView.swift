//
//  CardView.swift
//  Barista
//
//  Created by Rogier van den Brink on 10/01/2022.
//

import SwiftUI

struct CardView<Content: View>: ContainerView {
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        HStack(content: content)
            .padding()
            .background(Color.secondaryBackgroundColor)
            .cornerRadius(DefaultViewTraits.backgroundCornerRadius)
            .shadow(color: .shadowColor,
                    radius: DefaultViewTraits.shadowRadius)
            .setFullWidthAndHeight()
            
    }
}

protocol ContainerView: View {
    associatedtype Content
    init(content: @escaping () -> Content)
}

extension ContainerView {
    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.init(content: content)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView {
            Text("Hello")
        }
    }
}
