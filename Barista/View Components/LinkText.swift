//
//  LinkText.swift
//  Barista
//
//  Created by Rogier van den Brink on 10/01/2022.
//

import SwiftUI

struct LinkText: View {
    let textString: String
    
    init(_ textString: String) {
        self.textString = textString
    }
    
    var body: some View {
        Text(textString)
            .font(.linkFont)
            .fontWeight(.medium)
            .underline()
    }
}
