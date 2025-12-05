//
//  OnboardingScreenView.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 02/12/2025.
//

import SwiftUI

struct OnboardingScreenView: View {
    // MARK: - Properties
    @State var viewModel = OnboardingViewModel()
    @State var xScale: CGFloat = 1
    @State var yScale: CGFloat = 1
    @State var opacity: CGFloat = 1
    @Binding var doneWithOnboarding: Bool

    // MARK: - Drawing View
    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 0) {
                        ForEach(viewModel.screens.indices, id: \.self) { screnIndex in
                            getRelevantScreen(
                                for: screnIndex,
                                scrollProxy: proxy
                            )
                            .frame(width: geometry.size.width)
                            .id(screnIndex)
                        }
                    }
                }
                .scrollTargetBehavior(.paging)
                .scrollDisabled(true)
                .onAppear {
                    proxy.scrollTo(viewModel.currentPage, anchor: .leading)
                }
            }
        }
        .scaleEffect(x: xScale, y: yScale, anchor: .center)
        .opacity(opacity)
    }
    
    /// Getting the relevant screen based on the index of the screen to be displayed from the screens array in the viewModel
    @ViewBuilder
    private func getRelevantScreen(
        for index: Int,
        scrollProxy: ScrollViewProxy
    ) -> some View {
        switch viewModel.screens[index] {
        case .appIntro:
            AppIntroScreen {
                scrollPage(isForward: true, scrollProxy: scrollProxy)
            }
            
        case let .sectionIntro(introData):
            createSectionIntroductionScreen(
                for: index,
                introData: introData,
                scrollProxy: scrollProxy
            )
            
        case let .question(questionData):
            createQuestionsScreen(
                for: index,
                using: questionData,
                scrollProxy: scrollProxy
            )
            
        case let .nameEntry(name):
            createNameEntryScreen(
                for: index,
                initialName: name,
                scrollProxy: scrollProxy
            )
            
        case let .themeSelection(data):
            createBackgroundSlectionScreen(
                data: data,
                scrollProxy: scrollProxy,
                for: index
            )
        }
    }
    
    /// Section Inro screen
    private func createSectionIntroductionScreen(
        for index: Int,
        introData: SectionIntro,
        scrollProxy: ScrollViewProxy
    ) -> some View {
        SectionIntroView(
            currentPage: $viewModel.currentPage,
            pageIndex: index,
            image: introData.image,
            text: introData.text
        ) {
            if index < viewModel.screens.count - 1 {
                scrollPage(isForward: true, scrollProxy: scrollProxy)
            } else {
                viewModel.updateOnboardingStateInUeserDefaults(isDone: true)
                doneWithOnboarding = true
                withAnimation(.linear(duration: 0.2)) {
                    xScale = 2
                    yScale = 2
                    opacity = 0
                }
            }
        }
    }
    
    /// Creating question screen
    private func createQuestionsScreen(
        for index: Int,
        using questionData: Question,
        scrollProxy: ScrollViewProxy
    ) -> some View {
        QuestionView(
            question: questionData,
            didAnswerQuestion: { question in
                viewModel.screens[index] = .question(data: question)
                scrollPage(isForward: true, scrollProxy: scrollProxy)
                viewModel.saveUserChoices()
            },
            backButtonAction: {
                backButtonAction(scrollProxy: scrollProxy)
            }
        )
    }
    
    /// Name Entry screen creation
    private func createNameEntryScreen(
        for index: Int,
        initialName: String,
        scrollProxy: ScrollViewProxy
    ) -> some View {
        NameEntryView(
            name: initialName,
            backButtonAction: {
                backButtonAction(scrollProxy: scrollProxy)
            },
            continueButtonPressed: { name in
                viewModel.screens[index] = .nameEntry(name: name)
                scrollPage(isForward: true, scrollProxy: scrollProxy)
                viewModel.saveUserChoices()
            }
        )
    }
    
    /// Background Selection screen
    private func createBackgroundSlectionScreen(
        data: ThemeSelectionViewData,
        scrollProxy: ScrollViewProxy,
        for index: Int
    ) -> some View {
        ThemeSelectionView(
            data: data,
            backButtonAction: {
                backButtonAction(scrollProxy: scrollProxy)
            },
            continueButtonAction: { selectedThemeData in
                viewModel.screens[index] = .themeSelection(data: selectedThemeData)
                scrollPage(isForward: true, scrollProxy: scrollProxy)
                viewModel.saveUserChoices()
            }
        )
    }
    
    /// Back Button Action
    private func backButtonAction(scrollProxy: ScrollViewProxy) {
        if viewModel.screens[viewModel.currentPage - 1].isASectionIntro() {
            viewModel.currentPage -= 1
        }
        scrollPage(isForward: false, scrollProxy: scrollProxy)
    }
    
    /// Scrolling to the next or previous page
    private func scrollPage(
        isForward: Bool,
        scrollProxy: ScrollViewProxy
    ) {
        if viewModel.currentPage < viewModel.screens.count - 1 && isForward {
            viewModel.currentPage += 1
        } else if viewModel.currentPage > 0 && !isForward {
            viewModel.currentPage -= 1
        }
        withAnimation {
            scrollProxy.scrollTo(viewModel.currentPage, anchor: .leading)
        }
    }
}

// MARK: - Preview
#Preview {
    OnboardingScreenView(doneWithOnboarding: .constant(false))
}
