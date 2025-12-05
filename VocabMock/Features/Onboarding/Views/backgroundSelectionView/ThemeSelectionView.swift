//
//  ThemeSelectionView.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 03/12/2025.
//

import SwiftUI

struct ThemeSelectionView: View {
    // MARK: - Properties
    @State var themes: [Themes]
    @State var data: ThemeSelectionViewData
    var backButtonAction: () -> Void
    var continueButtonAction: (ThemeSelectionViewData) -> Void
    
    // MARK: - Initializer(s)
    init(
        data: ThemeSelectionViewData,
        backButtonAction: @escaping () -> Void,
        continueButtonAction: @escaping (ThemeSelectionViewData) -> Void
    ) {
        self.data = data
        self.backButtonAction = backButtonAction
        self.continueButtonAction = continueButtonAction
        themes = [data.selectedOption] + Themes.allCases.filter { $0 != data.selectedOption }
    }
    
    // MARK: - Drawing View
    var body: some View {
        ZStack {
            createBackgroundImage()
            VStack(spacing: 16) {
                createTopBar()
                createQuestionText()
                createThemeSelectionCarousel()
                Spacer()
                createContinueButton()
            }
            .padding(.horizontal, 16)
        }
    }
    
    // MARK: - Background Image
    private func createBackgroundImage() -> some View {
        Image(themes[0].getRespectiveImage())
            .resizable()
            .blur(radius: 10, opaque: true)
            .ignoresSafeArea()
    }
    
    // MARK: - Top Bar
    private func createTopBar() -> some View {
        HStack {
            BackButton(backButtonAction: backButtonAction)
                .padding(.leading, 4)
            Spacer()
        }
        .frame(minHeight: 48)
        .padding(.top, 8)
    }
    
    // MARK: - Question
    private func createQuestionText() -> some View {
        Text(data.question)
            .font(.system(size: 24, weight: .bold, design: .serif))
            .foregroundColor(themes[0].getRRespectiveColor())
            .lineLimit(nil)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 32)
            .padding(.vertical, 16)
    }
    
    // MARK: - Theme Selection view
    private func createThemeSelectionCarousel() -> some View {
        ZStack {
            ForEach(themes.reversed(), id: \.self) { theme in
                ThemeSelectionCell(
                    isSelected: theme == data.selectedOption,
                    index: themes.firstIndex(where: { $0 == theme }) ?? 0,
                    theme: theme,
                    swipeAction: {
                        animateCarousel()
                })
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        data.selectedOption = theme
                    }
                }
            }
        }
        .padding(.top, 32)
    }
    
    func animateCarousel() {
        let firstTheme = themes[0]
        themes.remove(at: 0)
        themes.append(firstTheme)
    }
    
    // MARK: - Continue Button
    private func createContinueButton() -> some View {
        VocabButton(
            text: "Continue",
            buttonAction: {
                continueButtonAction(data)
            }
        )
        .padding(.bottom, 8)
    }
}

// MARK: - Preview
#Preview {
    ThemeSelectionView(
        data: ThemeSelectionViewData(
            question: "Which theme would you like to start with?"
        ),
        backButtonAction: {},
        continueButtonAction: { _ in }
    )
}
