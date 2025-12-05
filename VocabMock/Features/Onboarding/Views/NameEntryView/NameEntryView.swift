//
//  NameEntryView.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 02/12/2025.
//

import SwiftUI

struct NameEntryView: View {
    // MARK: - Properties
    @FocusState var isFocused: Bool
    @State var name: String
    @State var initialName: String = ""
    @State var keyboardObserver = KeyboardObserver()
    var backButtonAction: () -> Void
    var continueButtonPressed: (String) -> Void
    
    // MARK: - Drawing View
    var body: some View {
        ZStack {
            Color.viewsBackground.ignoresSafeArea()
                .onTapGesture {
                    isFocused = false
                }
            VStack(spacing: 16) {
                createTopBar()
                createQuestionText()
                createNameTextField()
                Spacer()
                createContinueButton()
            }
            .padding(.horizontal, 16)
        }
        .onAppear {
            initialName = name
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isFocused = true
            }
        }
    }
    
    // MARK: - Top Bar
    private func createTopBar() -> some View {
        HStack {
            BackButton {
                loseFocusAndDoAnAction(backButtonAction)
            }
            .padding(.leading, 4)
            Spacer()
            createSkipButton()
        }
        .frame(minHeight: 48)
        .padding(.top, 8)
    }
    
    // MARK: - Skip button
    private func createSkipButton() -> some View {
        Button {
            loseFocusAndDoAnAction {
                name = initialName
                continueButtonPressed(initialName)
            }
        } label: {
            Text("Skip")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.primary)
        }
        .padding(.trailing, 4)
    }
    
    // MARK: - Question
    private func createQuestionText() -> some View {
        Text("What do you want to be called?")
            .font(.system(size: 24, weight: .bold, design: .serif))
            .foregroundColor(.primary)
            .lineLimit(nil)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 32)
            .padding(.vertical, 16)
    }
    
    // MARK: - TextField
    private func createNameTextField() -> some View {
        VocabTextField(
            text: $name,
            isFocused: $isFocused,
            placeholder: "Your name"
        )
    }
    
    // MARK: - Continue Button
    private func createContinueButton() -> some View {
        VocabButton(
            text: "Continue",
            buttonAction: {
                loseFocusAndDoAnAction {
                    continueButtonPressed(name)
                }
            }
        )
        .padding(.bottom, 8)
        .animation(.linear(duration: 0.1), value: -keyboardObserver.keyboardHeight)
    }
    
    // MARK: - Losing focus before doing any navigation for better animation
    private func loseFocusAndDoAnAction(_ action: @escaping () -> Void) {
        isFocused = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            action()
        }
    }
}

// MARK: - Preview
#Preview {
    NameEntryView(
        name: "",
        backButtonAction: {},
        continueButtonPressed: { _ in }
    )
}
