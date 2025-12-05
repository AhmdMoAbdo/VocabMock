//
//  Question.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 30/11/2025.
//

import Foundation

struct Question: Codable {
    var question: String
    var subQuestion: String?
    var answers: [String]
    var selectedAnswerIndicies: Set<Int> = []
    var isSkippable: Bool
    var answersViewMode: AnswerViewMode
    
    var allowMultipleSelections: Bool {
        switch answersViewMode {
        case .tags:
            true
            
        case let .multipleChoices(allowMultipleSelections):
            allowMultipleSelections
        }
    }
}
