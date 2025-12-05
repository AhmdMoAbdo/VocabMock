//
//  IntroScreenPromotionalView.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 01/12/2025.
//

import SwiftUI

struct IntroScreenPromotionalView: View {
    // MARK: - Drawing View
    var body: some View {
        HStack(spacing: 10) {
            createPromotionalTitleAndSubtitleTexts(title: "350 million", subtitle: "words learned")
            IntroScreenRatingView()
            createPromotionalTitleAndSubtitleTexts(title: "10 million", subtitle: "downloads")
        }
    }
    
    // MARK: - Title/Subtitle stack
    private func createPromotionalTitleAndSubtitleTexts(title: String, subtitle: String) -> some View {
        VStack {
            Text(title)
                .font(.system(size: 16, weight: .heavy))
                .foregroundStyle(.primary)
            
            Text(subtitle)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.primary)
        }
    }
}

// MARK: - Preview
#Preview {
    IntroScreenPromotionalView()
}
