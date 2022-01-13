//
//  SizesView.swift
//  Barista
//
//  Created by Rogier van den Brink on 11/01/2022.
//

import SwiftUI

struct SizesView: View{
    @ObservedObject var viewModel: SizesViewModel
    @State var active = false
    
    var body: some View {
        CoffeeNavigationView(
            destination: viewModel.navigateToExtras(),
            isRoot: false,
            title: viewModel.title,
            subtitle: viewModel.subtitle,
            active: _active
        ) {
            content()
        }
    }
}

private extension SizesView {
    func content() -> some View {
        if let viewModels = viewModel.rowViewModels {
            return AnyView(list(for: viewModels))
        } else {
            return AnyView(loading)
        }
    }
    
    func list(for viewModels: [SizeRowViewModel]) -> some View {
        ScrollView {
            ForEach(viewModels, id: \.id) { model in
                StyleCard(viewModel: model, expanded: false, subSelectionCallback: { _ in })
                    .onTapGesture(count: 1,
                                  perform: {
                        viewModel.selectOption(key: CoffeeOverviewKey.size.rawValue, value: model)
                        self.active = true
                    })
            }
        }
    }
    
    var loading: some View {
        Text(Localizable.loadingStyles.localized)
            .foregroundColor(.gray)
    }
}
