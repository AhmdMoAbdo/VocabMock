//
//  VocabTextField.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 02/12/2025.
//

import SwiftUI

struct VocabTextField: View {
    // MARK: - Properties
    @Binding var text: String
    @FocusState.Binding var isFocused: Bool
    let placeholder: String
    var height: CGFloat = 52
    
    // MARK: - Drawing View
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.textFieldPlaceHolderText)
                    .padding(.leading, 16)
            }
            
            TextField("", text: $text)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.primary)
                .padding(.leading, 16)
                .focused($isFocused)
        }
        .frame(height: height)
        .background(.textFieldBackground)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(.textFieldBorder, lineWidth: 1)
        }
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var text = ""
    @Previewable @FocusState var isFocused: Bool
    VocabTextField(text: $text, isFocused: $isFocused, placeholder: "Your name")
}
