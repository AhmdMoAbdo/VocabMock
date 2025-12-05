//
//  SectionIntroView.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 01/12/2025.
//

import SwiftUI
import Combine

struct SectionIntroView: View {
    // MARK: - Properties
    @State var imageScale: CGFloat = 0.3
    @Binding var currentPage: Int
    var pageIndex: Int
    var image: String?
    var text: String
    var didPressContinue: (() -> Void)
    
    // MARK: - Drawing View
    var body: some View {
        ZStack {
            Color.viewsBackground.ignoresSafeArea()
            VStack(spacing: 16) {
                createTopImage()
                createMiddleText()
                Spacer()
                createContinueButton()
            }
            .padding(.horizontal, 16)
        }
        .onReceive(Just(currentPage), perform: { _ in
            if currentPage == pageIndex {
                animateImage()
            }
        })
    }
    
    // MARK: - Animate image on initial appearance
    private func animateImage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.spring(response: 0.7, dampingFraction: 0.4, blendDuration: 0.5)) {
                imageScale = 1
            }
        }
    }
    
    // MARK: - Top Image
    @ViewBuilder
    private func createTopImage() -> some View {
        if let image {
            Image(image)
                .resizable()
                .frame(height: UIScreen.main.bounds.height / 2.5)
                .scaledToFill()
                .padding(.top, 48)
                .padding(.horizontal, -32)
                .scaleEffect(x: imageScale, y: imageScale)
        } else {
            Spacer()
        }
    }
    
    // MARK: - Middle Text    
    private func createMiddleText() -> some View {
        Text(text)
            .font(.system(size: 26, weight: .heavy, design: .serif))
            .foregroundColor(.primary)
            .lineLimit(nil)
            .multilineTextAlignment(.center)
            .lineSpacing(3)
            .padding(.horizontal, 48)
    }
    
    // MARK: - Continue Button
    private func createContinueButton() -> some View {
        VocabButton(
            text: "Continue",
            buttonAction: {
                didPressContinue()
            }
        )
        .padding(.bottom, 8)
    }
}

// MARK: - Preview
#Preview {
    SectionIntroView(
        currentPage: .constant(1),
        pageIndex: 1,
        image: "tailorRecommendationsImage",
        text: "Tailor your word recommendations") {}
}
