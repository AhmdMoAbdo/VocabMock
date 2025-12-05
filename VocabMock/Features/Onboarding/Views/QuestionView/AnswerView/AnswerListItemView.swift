//
//  AnswerView.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 30/11/2025.
//

import SwiftUI

struct AnswerListItemView: View {
    // MARK: - Properties
    @Environment(\.colorScheme) var colorScheme
    @State var bottomShadow: CGFloat = 4
    var isSelected: Bool
    var answerType: AnswerListItemViewtype
    var answerText: String
    var onTapAction: (() -> Void)

    // MARK: - Drawing view
    var body: some View {
        HStack {
            Text(answerText)
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(colorScheme == .dark && !isSelected ? .white : .black)
            Spacer()
            answerType.getRelativeView(isSelected)
        }
        .padding(.horizontal, 16)
        .addDefaultButtonStyle(
            backgroundColor: isSelected ? .answerClicked : .answerUnClicked,
            borderColor: .answerBorder,
            shadowColor: .answerBorder,
            bottomShadow: $bottomShadow
        )
        .addBounceAnimationOnClick(bottomShadow: $bottomShadow, completion: onTapAction)
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var selectedAnswerIndex: Int = 0    
    AnswerListItemView(
        isSelected: selectedAnswerIndex == 0,
        answerType: .checkBox,
        answerText: "Facebook"
    ) {
        selectedAnswerIndex = .random(in: 0..<3)
    }
    .padding(.horizontal, 16)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.viewsBackground)
}
