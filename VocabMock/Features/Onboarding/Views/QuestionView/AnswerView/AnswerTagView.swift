//
//  AnswerTagView.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 01/12/2025.
//

import SwiftUI

struct AnswerTagView: View {
    // MARK: - Properties
    @Environment(\.colorScheme) var colorScheme
    @State var bottomShadow: CGFloat = 4
    var answer: String
    var isSelected: Bool
    var onTapAction: () -> Void
    
    // MARK: - Drawing View
    var body: some View {
        HStack(spacing: 12) {
            addRelevantLeadingImage()
            addAnswerText()
        }
        .padding(.horizontal, 16)
        .addDefaultButtonStyle(
            width: nil,
            backgroundColor: isSelected ? .answerClicked : .answerUnClicked,
            borderColor: .answerBorder,
            shadowColor: .answerBorder,
            bottomShadow: $bottomShadow
        )
        .addBounceAnimationOnClick(bottomShadow: $bottomShadow, completion: onTapAction)
    }
    
    // MARK: - Leading Image
    private func addRelevantLeadingImage() -> some View {
        Image(systemName: isSelected ? "checkmark" : "plus")
            .resizable()
            .foregroundStyle(colorScheme == .dark && !isSelected ? .white : .black)
            .frame(width: 12, height: 12)
    }
    
    // MARK: - Text
    private func addAnswerText() -> some View {
        Text(answer)
            .font(.system(size: 18, weight: .medium))
            .foregroundStyle(colorScheme == .dark && !isSelected ? .white : .black)
    }
}

// MARK: - Preview
#Preview {
    AnswerTagView(
        answer: "History",
        isSelected: true,
        onTapAction: {}
    )
}
