//
//  StyleCard.swift
//  Barista
//
//  Created by Rogier van den Brink on 11/01/2022.
//

import SwiftUI

struct StyleCard<T: BaseRowViewModel>: View {
    private let viewModel: T
    
    var expanded: Bool
    
    @State var selectedSubselectionId: String = ""
    
    var subSelectionCallback: (Subselection) -> ()
    
    init(viewModel: T, expanded: Bool, subSelectionCallback: @escaping(Subselection) -> ()) {
        self.viewModel = viewModel
        self.expanded = expanded
        self.subSelectionCallback = subSelectionCallback
    }
    
    var body: some View {
         CardView {
             if let model = viewModel.model as? Extra,
                expanded {

                 extendedContent(subselections: model.subselections)
             } else {

                 baseContent
             }
         }
         .padding(top: 0,
                  leading: DefaultViewTraits.horizontalMargin,
                  bottom: 0,
                  trailing: DefaultViewTraits.horizontalMargin)
    }
    
    var baseContent: some View {
        HStack {
            // Only show image if there is an image
            if let image = viewModel.image {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: DefaultViewTraits.iconSize, height: DefaultViewTraits.iconSize, alignment: .leading)
                    .padding(top: DefaultViewTraits.verticalMarginSmall,
                             leading: DefaultViewTraits.horizontalMargin,
                             bottom: DefaultViewTraits.verticalMarginSmall,
                             trailing: 0)
            }
            Text(viewModel.title)
                .foregroundColor(.secondaryFontColor)
                .font(.cardFont)
                .frame(height: DefaultViewTraits.iconSize, alignment: .leading)
                .padding(.horizontal, DefaultViewTraits.horizontalMarginMedium)
            
            Spacer()
        }
    }
    
    func extendedContent(subselections: [Subselection]) -> some View {
        VStack {
            HStack {
                // Only show image if there is an image
                if let image = viewModel.image {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: DefaultViewTraits.iconSize, height: DefaultViewTraits.iconSize, alignment: .leading)
                        .padding(top: DefaultViewTraits.verticalMarginSmall,
                                 leading: DefaultViewTraits.horizontalMargin,
                                 bottom: DefaultViewTraits.verticalMarginSmall,
                                 trailing: 0)
                }
                Text(viewModel.title)
                    .foregroundColor(.secondaryFontColor)
                    .font(.cardFont)
                    .frame(height: DefaultViewTraits.iconSize, alignment: .leading)
                    .padding(.horizontal, DefaultViewTraits.horizontalMarginMedium)
                
                Spacer()
            }
            
            Divider()
                .frame(height: 1.0)
                .background(Color.white)
                .padding(top: DefaultViewTraits.verticalMargin,
                         leading: DefaultViewTraits.horizontalMarginSmall,
                         bottom: DefaultViewTraits.verticalMargin,
                         trailing: DefaultViewTraits.horizontalMarginSmall)
            
            ForEach(subselections, id: \.id) { selection in
                ExtraCardView(item: selection,
                              selected: .constant(selection.id == selectedSubselectionId),
                              callback: self.subselectionCallback)
            }
        }
    }
    
    func subselectionCallback(item: Subselection) {
        self.selectedSubselectionId = item.id
        self.subSelectionCallback(item)
    }
}
