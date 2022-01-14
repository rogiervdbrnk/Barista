//
//  StylesView.swift
//  Barista
//
//  Created by Rogier van den Brink on 10/01/2022.
//

import SwiftUI

struct StylesView: View {
    @ObservedObject var viewModel: StylesViewModel
    @State var active = false
    
    var body: some View {
        CoffeeNavigationView(
            destination: viewModel.navigateToSizes(),
            isRoot: false,
            title: viewModel.title,
            subtitle: viewModel.subtitle,
            active: _active
        ) {
            
            content()
        }
    }
}

private extension StylesView {
    func content() -> some View {
        if let viewModels = viewModel.rowViewModels {
            return AnyView(list(for: viewModels))
        } else {
            return AnyView(loading)
        }
    }
    
    func list(for viewModels: [StyleRowViewModel]) -> some View {
        ScrollView {
            ForEach(viewModels, id: \.id) { model in
                StyleCard(viewModel: model, expanded: false, subSelectionCallback: { _ in })
                    .onTapGesture(count: 1,
                                  perform: {
                        viewModel.selectOption(key: CoffeeOverviewKey.style.rawValue, value: model)
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
