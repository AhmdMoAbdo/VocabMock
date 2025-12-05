//
//  WordExplanationView.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 04/12/2025.
//

import SwiftUI

struct WordExplanationView: View {
    // MARK: - Properties
    var theme: Themes {
        UserDefaultsHandler.shared.selectedTheme
    }
    var word: Word
    
    // MARK: - Drawing View
    var body: some View {
        VStack(spacing: 26) {
            createText(text: word.word, fontSize: 40, fontWeight: .bold)
            createText(text: word.explanation, fontSize: 20, fontWeight: .semibold)
            createText(text: word.example, fontSize: 16, fontWeight: .regular)
        }
        .padding(.horizontal, 26)
    }
    
    // MARK: - View Texts
    private func createText(
        text: String,
        fontSize: CGFloat,
        fontWeight: Font.Weight
    ) -> some View {
        Text(text)
            .font(theme.getRespectiveFont(fontSize: fontSize, fontWeight: fontWeight))
            .foregroundStyle(theme.getRRespectiveColor())
            .lineLimit(nil)
            .multilineTextAlignment(.center)
    }
}

// MARK: - Preview
#Preview {
    WordExplanationView(
        word: Word(
            word: "altruistic",
            explanation: "(adj.) Caring for others without expecting anything in return.",
            example: "His altruistic actions earned him much respect."
        )
    )
}
