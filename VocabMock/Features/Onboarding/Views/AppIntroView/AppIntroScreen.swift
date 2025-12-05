//
//  AppIntroScreen.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 01/12/2025.
//

import SwiftUI

struct AppIntroScreen: View {
    // MARK: - Properties
    var didPressContinue: (() -> Void)
    
    // MARK: - Drawing View
    var body: some View {
        ZStack {
            Color.viewsBackground.ignoresSafeArea()
            VStack(spacing: 16) {
                createTopImage()
                createMiddleTextViews()
                Spacer()
                IntroScreenPromotionalView()
                Spacer()
                createContinueButton()
            }
        }
    }
    
    // MARK: - Top Image
    private func createTopImage() -> some View {
        Image(.appIntro)
            .resizable()
            .frame(height: UIScreen.main.bounds.height / 2.5)
            .scaledToFill()
            .padding(.top, 8)
    }
    
    // MARK: - Middle Texts
    private func createMiddleTextViews() -> some View {
        VStack(spacing: 8) {
            createMiddleTitleText()
            createMiddleSubtitleText()
        }
        .padding(.horizontal, 16)
    }
    
    /// Title
    private func createMiddleTitleText() -> some View {
        Text("Expand your Vocabulary in\n1 minute a day")
            .font(.system(size: 24, weight: .bold, design: .serif))
            .foregroundColor(.primary)
            .lineLimit(nil)
            .lineSpacing(3)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 24)
    }
    
    /// Subtitle
    private func createMiddleSubtitleText() -> some View {
        Text("Learn 10,000+ new words with a new daily habit that takes just 1 minute")
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.primary)
            .lineLimit(nil)
            .lineSpacing(3)
            .multilineTextAlignment(.center)
    }
    
    // MARK: - Continue Button
    private func createContinueButton() -> some View {
        VocabButton(
            text: "Get started",
            buttonAction: {
                didPressContinue()
            }
        )
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }
}

// MARK: - Preview
#Preview {
    AppIntroScreen {}
}
