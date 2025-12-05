//
//  HomeViewModel.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 04/12/2025.
//

import Foundation

@Observable
class HomeViewModel {
    var words: [Word] = [
        Word(
            word: "altruistic",
            explanation: "(adj.) Caring for others without expecting anything in return.",
            example: "His altruistic actions earned him much respect."
        ),
        Word(
            word: "sedulous",
            explanation: "(adj.) Working hard and never giving up.",
            example: "Her sedulous study habits paid off."
        ),
        Word(
            word: "indelible",
            explanation: "(adj.) Impossible to erase or forget.",
            example: "Her smile left an indelible mark on his heart."
        ),
        Word(
            word: "ineffable",
            explanation: "(adj.) Too great or extreme to be expressed or described in words.",
            example: "The ineffable beauty of the sunset left them speechless."
        ),
        Word(
            word: "indolent",
            explanation: "(adj.) Unmotivated or not trying.",
            example: "The indolent emoployee expected his coworkers to coplete his unfinished project."
        )
    ]
}
