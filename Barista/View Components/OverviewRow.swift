//
//  OverviewRow.swift
//  Barista
//
//  Created by Rogier van den Brink on 12/01/2022.
//

import SwiftUI

struct OverviewRow: View {
    private let model: OverviewRowViewModel
    
    var isLastRow: Bool
    
    let callback: (OverviewRowViewModel) -> ()
    
    init(model: OverviewRowViewModel, isLastRow: Bool, callback: @escaping(OverviewRowViewModel) -> ()) {
        self.model = model
        self.isLastRow = isLastRow
        self.callback = callback
    }
    
    var body: some View {
        VStack {
            if model.isSubselection {
                
                ExtraCardView(item: Subselection(id: "", name: model.name ?? ""), selected: .constant(true), callback: { _ in
                    callback(model)
                })
                    .frame(height: DefaultViewTraits.cellHeight)
                
            } else {
                HStack {
                    // Only show image if there is an image
                    if let image = model.image {
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: DefaultViewTraits.iconSize, height: DefaultViewTraits.iconSize, alignment: .leading)
                            .padding(top: DefaultViewTraits.verticalMarginSmall,
                                     leading: DefaultViewTraits.horizontalMargin,
                                     bottom: DefaultViewTraits.verticalMarginSmall,
                                     trailing: 0)
                    }
                    Text(model.name ?? "")
                        .foregroundColor(.secondaryFontColor)
                        .font(.cardFont)
                        .frame(height: DefaultViewTraits.iconSize, alignment: .leading)
                        .padding(.horizontal, DefaultViewTraits.horizontalMarginMedium)
                    
                    Spacer()
                    
                    Text(Localizable.editTitle.localized)
                        .foregroundColor(.secondaryFontColor)
                        .font(.cardFont)
                        .frame(height: DefaultViewTraits.iconSize, alignment: .trailing)
                        .padding(.horizontal, DefaultViewTraits.horizontalMarginMedium)
                        .onTapGesture {
                            callback(model)
                        }
                }
            }
            
            if !isLastRow {
                Divider()
                    .frame(height: 1.0)
                    .background(Color.white)
                    .padding( .vertical, DefaultViewTraits.horizontalMarginSmall)
            }
        }
    }
}
