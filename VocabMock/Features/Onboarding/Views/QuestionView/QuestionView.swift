//
//  QuestionView.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 30/11/2025.
//

import SwiftUI

struct QuestionView: View {
    // MARK: - Properties
    @State var question: Question
    @State var initialQuestion: Question
    var didAnswerQuestion: (Question) -> Void
    var backButtonAction: (() -> Void)
    
    // MARK: - Initializer(s)
    init(question: Question, didAnswerQuestion: @escaping (Question) -> Void, backButtonAction: @escaping () -> Void) {
        self.question = question
        self.initialQuestion = question
        self.didAnswerQuestion = didAnswerQuestion
        self.backButtonAction = backButtonAction
    }
    
    // MARK: - Drawing view
    var body: some View {
        ZStack {
            Color.viewsBackground.ignoresSafeArea()
            VStack(spacing: 16) {
                createTopBar()
                createQuestionText()
                createChoicesViews()
                Spacer()
                createContinueButton()
            }
            .padding(.horizontal, 16)
        }
    }
    
    // MARK: - Top Bar
    private func createTopBar() -> some View {
        HStack {
            BackButton(backButtonAction: backButtonAction)
                .padding(.leading, 4)
            
            Spacer()
            if question.isSkippable{
                createSkipButton()
            }
        }
        .frame(minHeight: 48)
        .padding(.top, 8)
    }
    
    // MARK: - Skip button
    private func createSkipButton() -> some View {
        Button {
            didAcquireAnswer(isSkipped: true)
        } label: {
            Text("Skip")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.primary)
        }
        .padding(.trailing, 4)
    }
    
    // MARK: - Question
    private func createQuestionText() -> some View {
        VStack(spacing: 12) {
            Text(question.question)
                .font(.system(size: 24, weight: .bold, design: .serif))
                .foregroundColor(.primary)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
            
            if let subQuestion = question.subQuestion {
                Text(subQuestion)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.primary)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 16)
    }
    
    // MARK: - Choices
    @ViewBuilder
    private func createChoicesViews() -> some View {
        switch question.answersViewMode {
        case .tags:
            createTagChoices()
            
        case .multipleChoices:
            createMultipleChoices()
        }
    }
    
    /// Multiple choices
    private func createMultipleChoices() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            Color.clear.frame(height: 4)
            ForEach(question.answers.indices, id: \.self) { answerIndex in
                AnswerListItemView(
                    isSelected: question.selectedAnswerIndicies.contains(answerIndex),
                    answerType: question.allowMultipleSelections ? .checkBox : .radioButton,
                    answerText: question.answers[answerIndex]) {
                        handleAnswerClick(for: answerIndex)
                    }
            }
            .padding(.horizontal, 2)
        }
        .padding(.horizontal, -2)
        .scrollBounceBehavior(.basedOnSize)
    }
    
    /// Tags
    private func createTagChoices() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            Color.clear.frame(height: 4)
            FlowLayout(spacing: 8, rowSpacing: 12) {
                ForEach(question.answers.indices, id: \.self) { answerIndex in
                    AnswerTagView(
                        answer: question.answers[answerIndex],
                        isSelected: question.selectedAnswerIndicies.contains(answerIndex)
                    ) {
                        handleAnswerClick(for: answerIndex)
                    }
                }
            }
            .padding(.horizontal, 2)
        }
        .padding(.horizontal, -2)
        .scrollBounceBehavior(.basedOnSize)
    }
    
    /// Answer button click
    private func handleAnswerClick(for index: Int) {
        if question.allowMultipleSelections {
            if question.selectedAnswerIndicies.contains(index) {
                question.selectedAnswerIndicies.remove(index)
            } else {
                question.selectedAnswerIndicies.insert(index)
            }
        } else {
            question.selectedAnswerIndicies = [index]
            didAcquireAnswer(isSkipped: false)
        }
    }
    
    // MARK: - Continue Button
    @ViewBuilder
    private func createContinueButton() -> some View {
        if question.allowMultipleSelections {
            VocabButton(
                text: "Continue",
                buttonAction: {
                    didAcquireAnswer(isSkipped: false)
                }
            )
            .padding(.bottom, 8)
        }
    }
    
    // MARK: - Navigate with the modified
    private func didAcquireAnswer(isSkipped: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            didAnswerQuestion(isSkipped ? initialQuestion : question)
            if isSkipped {
                question = initialQuestion
            } else {
                initialQuestion = question
            }
        }
    }
}

// MARK: - Preview
#Preview {
    QuestionView(
        question: Question(
            question: "How did you hear about Vocabulary?",
            subQuestion: "Learn more words per day",
            answers: ["Instagram", "Friend / Family", "Tiktok", "App Store", "Facebook", "Web Search", "Other"],
            isSkippable: true,
            answersViewMode: .multipleChoices(allowMultipleSelections: false)
        ),
        didAnswerQuestion: { _ in },
        backButtonAction: { }
    )
}

// MARK: - Preview
#Preview {
    QuestionView(
        question: Question(
            question: "What categories are you interested in?",
            answers: ["Curse words", "Litreature", "Funny words", "Society", "Business", "History", "Communication", "Emotions", "Art", "Sexology", "Expressions", "People", "Music", "Body", "Slang", "Beautiful words", "Cuisine"],
            isSkippable: true,
            answersViewMode: .tags
        ),
        didAnswerQuestion: { _ in },
        backButtonAction: { }
    )
}
