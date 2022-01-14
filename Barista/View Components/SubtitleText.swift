//
//  SubtitleText.swift
//  Barista
//
//  Created by Rogier van den Brink on 10/01/2022.
//

import Foundation
import SwiftUI

struct SubtitleText: View {
    
    let textString: String
    
    init(_ textString: String) {
        self.textString = textString
    }
    
    var body: some View {
        Text(textString)
            .fontWeight(.medium)
            .font(.largeTitleFont)
    }
}
