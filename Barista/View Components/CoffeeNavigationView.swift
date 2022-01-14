//
//  CoffeeNavigationView.swift
//  Barista
//
//  Created by Rogier van den Brink on 10/01/2022.
//

import SwiftUI

struct CoffeeNavigationView<Content: View, Destination: View>: View {
    let destination: Destination
    let isRoot: Bool
    let content: Content
    let title: String
    let subtitle: String
    @State var active: Bool
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
        
    init(destination: Destination,
         isRoot: Bool,
         title: String,
         subtitle: String,
         active: State<Bool>,
         @ViewBuilder content: () -> Content
    ) {
        self.destination = destination
        self.isRoot = isRoot
        self.title = title
        self.subtitle = subtitle
        self._active = active
        self.content = content()
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    ZStack {
                        HStack(alignment: .center) {
                            if !isRoot {
                                Image(AssetName.backButton.rawValue)
                                    .renderingMode(.template)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .tint(colorScheme == .dark ? .white : .black)
                                    .frame(height: DefaultViewTraits.navbarArrowSize)
                                    .padding(top: DefaultViewTraits.navbarArrowTopMargin,
                                             leading: 0,
                                             bottom: 0,
                                             trailing: DefaultViewTraits.navbarArrowMargin)
                                .onTapGesture(count: 1, perform: {
                                    self.mode.wrappedValue.dismiss()
                                })
                            }
                            Spacer()
                            
                            headerView
                                                        
                            NavigationLink(
                                destination: destination.navigationBarHidden(true)
                                    .navigationBarHidden(true),
                                isActive: self.$active,
                                label: {
                                    //no label
                                })
                                .isDetailLink(false)
                                .navigationViewStyle(StackNavigationViewStyle())
                        }
                        .padding([.leading,.trailing], DefaultViewTraits.navbarArrowMargin)
                        .frame(width: geometry.size.width)
                        .font(.system(size: 22))
                        
                        SubtitleText(subtitle)
                            .setFullWidth()
                            .padding(top: DefaultViewTraits.navbarHeight + DefaultViewTraits.verticalMargin,
                                     leading: DefaultViewTraits.horizontalMargin,
                                     bottom: 0,
                                     trailing: DefaultViewTraits.horizontalMargin)
                    }
                    .frame(width: geometry.size.width, height: 80)
                    .edgesIgnoringSafeArea(.top)
                    
                    self.content
                        
                    Spacer()
                }
            }.navigationBarHidden(true)
        }
    }
}

extension CoffeeNavigationView {
    var headerView: some View {
        VStack(alignment: .leading,
               spacing: DefaultViewTraits.spacing,
               content: {
            
            TitleText(title)
            
        })
            .setFullWidth()
            .padding(.top, DefaultViewTraits.verticalMargin)
    }
}
