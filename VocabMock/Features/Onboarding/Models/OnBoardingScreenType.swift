//
//  OnBoardingScreenType.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 03/12/2025.
//

import Foundation

enum OnBoardingScreenType: Equatable, Codable {
    case appIntro
    case sectionIntro(data: SectionIntro)
    case question(data: Question)
    case nameEntry(name: String)
    case themeSelection(data: ThemeSelectionViewData)
    
    // MARK: - Equitable
    static func == (lhs: OnBoardingScreenType, rhs: OnBoardingScreenType) -> Bool {
        switch (lhs, rhs) {
        case (.appIntro, .appIntro),
            (.sectionIntro(_), .sectionIntro(_)),
            (.question(_), .question(_)),
            (.nameEntry(_), .nameEntry(_)),
            (.themeSelection(_), .themeSelection(_)):
            return true
            
        default:
            return false
        }
    }
    
    // MARK: -  returns whether the current screen is a section intro or not
    func isASectionIntro() -> Bool {
        switch self {
        case .appIntro, .question, .nameEntry, .themeSelection:
            return false
            
        case .sectionIntro:
            return true
        }
    }
    
    // MARK: -  Extracting the saved user name from inside the nameEntry type
    func getUserName() -> String? {
        switch self {
        case let .nameEntry(name):
            return name
            
        default:
            return ""
        }
    }
    
    // MARK: - Extracting the selected theme from inside the themeSelection type
    func getSelectedTheme() -> Themes? {
        switch self {
        case let .themeSelection(data):
            return data.selectedOption
            
        default:
            return nil
        }
    }
    
    // MARK: - Default list of question when the user enters the app for the first time
    static func getDefaultScreensList() -> [OnBoardingScreenType] {
        return [
            .appIntro,
            .question(
                data: Question(
                    question: "How did you hear about Vocabulary?",
                    answers: ["Tiktok", "Facebook", "App Store", "Web Search", "Friend/Family", "Instagram", "Other"],
                    isSkippable: false,
                    answersViewMode: .multipleChoices(allowMultipleSelections: false)
                )
            ),
            .sectionIntro(
                data: SectionIntro(
                    image: "tailorRecommendationsImage",
                    text: "Tailor your word recommendations"
                )
            ),
            .question(
                data: Question(
                    question: "How old are you?",
                    answers: ["13 to 17", "18 to 24", "25 to 34", "35 to 44", "45 to 54", "55+"],
                    isSkippable: true,
                    answersViewMode: .multipleChoices(allowMultipleSelections: false)
                )
            ),
            .question(
                data: Question(
                    question: "Which option represents you best?",
                    answers: ["Female", "Male", "Other", "Prefer not to say"],
                    isSkippable: false,
                    answersViewMode: .multipleChoices(allowMultipleSelections: false)
                )
            ),
            .nameEntry(name: ""),
            .sectionIntro(
                data: SectionIntro(
                    image: "customizeExperience",
                    text: "Customize the app to improve your experience"
                )
            ),
            .question(
                data: Question(
                    question: "How many words do you want to learn per week?",
                    answers: ["10 words a week", "30 words a week", "50 words a week"],
                    isSkippable: true,
                    answersViewMode: .multipleChoices(allowMultipleSelections: false)
                )
            ), // Fire
            .question(
                data: Question(
                    question: "What's your vocabulary level?",
                    answers: ["Beginner", "Intermediate", "Advanced"],
                    isSkippable: true,
                    answersViewMode: .multipleChoices(allowMultipleSelections: false)
                )
            ),
            .themeSelection(
                data: ThemeSelectionViewData(
                    question: "Which theme would you like to start with?"
                )
            ),
            .sectionIntro(
                data: SectionIntro(
                    image: "vocabSetup",
                    text: "Set up Vocabulary to help you achieve your goals"
                )
            ),
            .question(
                data: Question(
                    question: "Which topics are you interested in?",
                    answers: ["Society", "Words in foreign languages", "Human body", "Business", "Emotions", "Other"],
                    isSkippable: false,
                    answersViewMode: .multipleChoices(allowMultipleSelections: true)
                )
            ),
            .question(
                data: Question(
                    question: "What categories are you interested in?",
                    answers: ["Curse words", "Litreature", "Funny words", "Society", "Business", "History", "Communication", "Emotions", "Art", "Sexology", "Expressions", "People", "Music", "Body", "Slang", "Beautiful words", "Cuisine"],
                    isSkippable: true,
                    answersViewMode: .tags
                )
            ),
            .question(
                data: Question(
                    question: "Do you have a specific goal in mind?",
                    answers: ["Enhance my lexicon", "Get ready for a test", "Improve my job prospects", "Enjoy learning new words", "Other"],
                    isSkippable: true,
                    answersViewMode: .multipleChoices(allowMultipleSelections: true)
                )
            ),
            .sectionIntro(
                data: SectionIntro(
                    image: nil,
                    text: "Amazing! \nlet's test how many words you know"
                )
            ),
            .question(
                data: Question(
                    question: "Beginner words",
                    subQuestion: "Select all the ones you know",
                    answers: ["Squint", "Genuine", "Whisper", "Metal", "Borrow", "Jumble"],
                    isSkippable: false,
                    answersViewMode: .multipleChoices(allowMultipleSelections: true)
                )
            ),
            .question(
                data: Question(
                    question: "Intermediate words",
                    subQuestion: "Select all the ones you know",
                    answers: ["Whet", "Squander", "Morose", "Deportment", "Pevasive", "Impeccable"],
                    isSkippable: false,
                    answersViewMode: .multipleChoices(allowMultipleSelections: true)
                )
            ),
            .question(
                data: Question(
                    question: "Advanced words",
                    subQuestion: "Select all the ones you know",
                    answers: ["Logophile", "Lucubration", "Callipgyan", "Numinous", "Superincumbent", "Quixotic"],
                    isSkippable: false,
                    answersViewMode: .multipleChoices(allowMultipleSelections: true)
                )
            ),
            .sectionIntro(
                data: SectionIntro(
                    image: "startLearning",
                    text: "Great! \nYou'll learn words that will take you to the next level"
                )
            ),
        ]
    }
}
