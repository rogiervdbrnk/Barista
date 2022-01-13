//
//  TitleText.swift
//  Barista
//
//  Created by Rogier van den Brink on 10/01/2022.
//

import Foundation
import SwiftUI

struct TitleText: View {
    
    let textString: String
    
    init(_ textString: String) {
        self.textString = textString
    }
    
    var body: some View {
        Text(textString)
            .font(.boldTitleFont)
    }
}
