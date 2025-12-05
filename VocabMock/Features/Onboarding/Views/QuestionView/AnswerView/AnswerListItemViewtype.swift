//
//  AnswerViewtype.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 30/11/2025.
//

import SwiftUI

/// Different types of answer view modes
enum AnswerViewMode: Codable {
    case tags
    case multipleChoices(allowMultipleSelections: Bool)
}

/// The type of the answer field in the onBoarding questions
enum AnswerListItemViewtype {
    case radioButton
    case checkBox
    
    /// Getting realtive view per each type
    @ViewBuilder
    func getRelativeView(_ isSelected: Bool) -> some View {
        switch self {
        case .radioButton:
            RadioButton(isSelected: isSelected)
                .animation(nil, value: false)
            
        case .checkBox:
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .background(.white)
                    .foregroundStyle(.dark)
                    .clipShape(Circle())
                    .animation(nil, value: false)
            }
        }
    }
}
