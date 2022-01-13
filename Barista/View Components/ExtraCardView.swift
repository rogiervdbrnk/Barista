//
//  ExtraCardView.swift
//  Barista
//
//  Created by Rogier van den Brink on 11/01/2022.
//

import SwiftUI

struct ExtraCardView: View {
    private var item: Subselection
    
    @Binding var selected: Bool
    
    let callback: (Subselection) -> ()
    
    init(item: Subselection, selected: Binding<Bool>, callback: @escaping(Subselection) -> ()) {
        self.item = item
        self._selected = selected
        self.callback = callback
    }
    
    var body: some View {
        HStack {
            Text(item.name)
                .foregroundColor(.secondaryFontColor)
                .font(.cardFont)
                .frame(height: DefaultViewTraits.iconSize, alignment: .leading)
                .padding(.horizontal, DefaultViewTraits.horizontalMarginMedium)
            
            Spacer()
            
            if selected {
                Image(AssetName.checked.rawValue)
                    .resizable()
                    .frame(width: DefaultViewTraits.checkboxSize,
                           height: DefaultViewTraits.checkboxSize,
                           alignment: .trailing)
                    
                    .aspectRatio(contentMode: .fit)
                    .padding(.trailing, DefaultViewTraits.horizontalMarginMedium)
            } else {
                Image(AssetName.unchecked.rawValue)
                    .resizable()
                    .frame(width: DefaultViewTraits.checkboxSize,
                           height: DefaultViewTraits.checkboxSize,
                           alignment: .trailing)
                    
                    .aspectRatio(contentMode: .fit)
                    .padding(.trailing, DefaultViewTraits.horizontalMarginMedium)
            }
        }
        .setFullWidthAndHeight()
        .background(Color.tertiaryBackgroundColor)
        .cornerRadius(DefaultViewTraits.extraCornerRadius)
        .onTapGesture {
            self.callback(item)
            self.selected.toggle()
        }
        
    }
}
