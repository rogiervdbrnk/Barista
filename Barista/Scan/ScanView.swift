//
//  ScanView.swift
//  Barista
//
//  Created by Rogier van den Brink on 10/01/2022.
//

import SwiftUI

struct ScanView: View {
    @ObservedObject var viewModel: ScanViewModel
    @State var active = false
    
    init(viewModel: ScanViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        CoffeeNavigationView(
            destination: viewModel.navigateToStyles(),
            isRoot: true,
            title: viewModel.title,
            subtitle: viewModel.subtitle,
            active: _active
        ) {
            VStack {
                
                Spacer()
                
                imageView
                
                Spacer()
                
                footerView
                
                Spacer()
            }
            .setFullWidthAndHeight()
        }
    }
}

extension ScanView {
    
    var imageView: some View {
        Image(AssetName.coffeeMachine.rawValue)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onTapGesture(count: 1,
                          perform: {
                self.active = true
            })
    }
    
    var footerView: some View {
        VStack(alignment: .leading,
               spacing: DefaultViewTraits.spacing,
               content: {
            
            LinkText(Localizable.explanationTitle.localized)
        })
            .setFullWidth()
            .padding(.horizontal, DefaultViewTraits.horizontalMargin)
    }
}
