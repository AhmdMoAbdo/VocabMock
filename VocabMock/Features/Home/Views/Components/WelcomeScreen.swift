//
//  WelcomeScreen.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 04/12/2025.
//

import SwiftUI

struct WelcomeScreen: View {
    // MARK: - Properties
    @State var timer: Timer?
    @State var arrowPosition: CGFloat = 0
    @State var swipeupOpacity: CGFloat = 0
    @State var textPosition: CGFloat = 200
    @State var textOpacity: CGFloat = 0
    private var theme: Themes {
        UserDefaultsHandler.shared.selectedTheme
    }
    
    // MARK: - Drawing View
    var body: some View {
        ZStack {
            createWelcomeText()
            createSwipeUpToStartView()
        }
        .frame(height: UIScreen.main.bounds.height)
        .onAppear {
            startScreenContentAnimation()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    /// Animating the screen content to their respective positiion when the view appears
    private func startScreenContentAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.linear(duration: 0.5)) {
                textPosition = 0
                textOpacity = 1
            } completion: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
                        animateArrow()
                    }
                    withAnimation(.linear(duration: 1)) {
                        swipeupOpacity = 1
                    }
                }
            }
        }
    }
    
    /// Animate swipeup arrow up and down
    private func animateArrow() {
        withAnimation(.linear(duration: 0.2)) {
            arrowPosition = -16
        } completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.linear(duration: 0.2)) {
                    arrowPosition = 0
                }
            }
        }

    }
    
    // MARK: - Welcome text
    private func createWelcomeText() -> some View {
        Text("Welcome to Vocabulary")
            .font(theme.getRespectiveFont())
            .foregroundStyle(theme.getRRespectiveColor())
            .offset(y: textPosition)
            .opacity(textOpacity)
    }
    
    // MARK: - Swipe up view
    private func createSwipeUpToStartView() -> some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "chevron.up")
                .resizable()
                .frame(width: 28, height: 16)
                .foregroundStyle(theme.getRRespectiveColor())
                .offset(y: arrowPosition)
            
            Text("Swipe up")
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(theme.getRRespectiveColor())
        }
        .opacity(swipeupOpacity)
        .padding(.bottom, 32)
    }
}

// MARK: - Preview
#Preview {
    WelcomeScreen()
}
