//
//  OverviewView.swift
//  Barista
//
//  Created by Rogier van den Brink on 11/01/2022.
//

import SwiftUI

struct OverviewView: View {
    @ObservedObject var viewModel: OverviewViewModel
    @State var active = false
    @State var destination: CoffeeScreen? = nil
    @State private var showingAlert = false
    
    var body: some View {
        CoffeeNavigationView(
            destination: viewModel.navigateBack(for: destination),
            isRoot: false,
            title: viewModel.title,
            subtitle: viewModel.subtitle,
            active: _active
        ) {
            VStack {
                content()
                
                Spacer()
                    .frame(minHeight: 0, maxHeight: .infinity)
                
                VStack {
                    Spacer()
                        .frame(minHeight: 0, maxHeight: .infinity)
                    
                    buttonView
                }
            }
        }
    }
}

private extension OverviewView {
    func content() -> some View {
        CardView {
            list(for: viewModel.overviewModels)
        }
        .padding()
    }
    
    func list(for viewModels: [OverviewRowViewModel]) -> some View {
        VStack {
            ForEach(viewModels, id: \.id) { model in
                OverviewRow(model: model,
                            isLastRow: model == viewModels.last,
                            callback: { overviewModel in
                    
                    destination = overviewModel.type
                    self.active.toggle()
                })
                
            }
        }
    }
    
    var buttonView: some View {
        CardView {
            Text(Localizable.overviewButtonTitle.localized)
                .font(.boldTitleFont)
                .foregroundColor(.white)
                .setFullWidth()
                .padding()
        }
        .padding()
        .onTapGesture {
            self.showingAlert = true
        }
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text(Localizable.confirmationTitle.localized),
                  message: Text(Localizable.confirmationMessage.localized),
                  dismissButton: .default(Text(Localizable.okText.localized)))
        })
    }
    
    var loading: some View {
        Text(Localizable.loadingStyles.localized)
            .foregroundColor(.gray)
    }
}


