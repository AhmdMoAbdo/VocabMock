//
//  Home.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 04/12/2025.
//

import SwiftUI

struct Home: View {
    // MARK: - Properties
    @State var viewModel = HomeViewModel()
    @State var showWelcomeScreen: Bool = true
    var theme: Themes {
        UserDefaultsHandler.shared.selectedTheme
    }
    
    // MARK: - Drawing View
    var body: some View {
        ZStack {
            createBackgroundImage()
            GeometryReader { geometry in
                ScrollViewReader { proxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            createScrollOffsetReader(proxy: proxy)
                            
                            if showWelcomeScreen {
                                WelcomeScreen()
                            }
                            
                            createWordsList(itemHeight: geometry.size.height)
                        }
                    }
                    .scrollTargetBehavior(.paging)
                }
            }
        }
        .ignoresSafeArea()
    }
    
    // MARK: - Background Image
    private func createBackgroundImage() -> some View {
        Image(theme.getRespectiveImage())
            .resizable()
            .scaledToFit()
    }
    
    // MARK: - Scroll offset reader to calculate current offset and hide the welcome top view
    private func createScrollOffsetReader(proxy: ScrollViewProxy) -> some View {
        ScrollOffsetReader { offsetY in
            if offsetY == UIScreen.main.bounds.height && showWelcomeScreen {
                showWelcomeScreen = false
                UserDefaultsHandler.shared.didShowHomeWelcomeScreen = true
                proxy.scrollTo(0)
                
            }
        }
        .frame(height: 0)
    }
    
    // MARK: - Words
    private func createWordsList(itemHeight: CGFloat) -> some View {
        LazyVStack(spacing: 0) {
            ForEach(viewModel.words.indices, id: \.self) { index in
                WordExplanationView(word: viewModel.words[index])
                    .frame(height: itemHeight)
                    .id(index)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    Home()
}
