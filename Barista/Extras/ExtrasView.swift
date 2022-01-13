//
//  ExtrasView.swift
//  Barista
//
//  Created by Rogier van den Brink on 11/01/2022.
//

import SwiftUI

struct ExtrasView: View {
    @ObservedObject var viewModel: ExtrasViewModel
    @State var active = false
    
    var body: some View {
        CoffeeNavigationView(
            destination: viewModel.navigateToOverview(),
            isRoot: false,
            title: viewModel.title,
            subtitle: viewModel.subtitle,
            active: _active
        ) {
            content()
                .onTapGesture(count: 1,
                              perform: {
                    
                    self.active.toggle()
                })
        }
    }
}

private extension ExtrasView {
    func content() -> some View {
        if let viewModels = viewModel.rowViewModels {
            return AnyView(list(for: viewModels))
        } else {
            return AnyView(loading)
        }
    }
    
    func list(for viewModels: [ExtraRowViewModel]) -> some View {
        VStack {
            ScrollView {
                ForEach(viewModels, id: \.id) { model in
                    StyleCard(viewModel: model, expanded: viewModel.selection.contains(model), subSelectionCallback: { selection in
                        viewModel.selectOption(key: CoffeeOverviewKey.subselection.rawValue, value: selection)
                        viewModel.selectOption(key: CoffeeOverviewKey.extra.rawValue, value: model)
                    })
                        .onTapGesture(count: 1,
                                      perform: {
                            
                            viewModel.selectDeselect(model)
                        })
                        .animation(.easeIn(duration: 0.3), value: viewModel.selection)
                }
            }
            Text(Localizable.continueTitle.localized)
                .font(.boldTitleFont)
        }
    }
    
    var loading: some View {
        Text(Localizable.loadingStyles.localized)
            .foregroundColor(.gray)
    }
}
