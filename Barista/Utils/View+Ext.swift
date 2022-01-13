//
//  View+Ext.swift
//  Barista
//
//  Created by Rogier van den Brink on 10/01/2022.
//

import Foundation
import SwiftUI

extension View {
    func setFullWidthAndHeight() -> some View {
        self.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
    
    func setFullWidth() -> some View {
        self.frame(minWidth: 0,
                   maxWidth: .infinity,
                   alignment: .leading)
    }
    
    func padding(top: CGFloat,
                 leading: CGFloat,
                 bottom: CGFloat,
                 trailing: CGFloat
    ) -> some View {
        self.padding(EdgeInsets(top: top,
                                leading: leading,
                                bottom: bottom,
                                trailing: trailing))
    }
}
