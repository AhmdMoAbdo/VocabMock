//
//  OnboardingViewModel.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 02/12/2025.
//

import Foundation

@Observable
class OnboardingViewModel {
    // MARK: - Screen list
    var screens: [OnBoardingScreenType]
    var currentPage: Int = 0 {
        didSet {
            UserDefaultsHandler.shared.currentScreenIndex = currentPage
        }
    }
    
    // MARK: - Initializer(s)
    init() {
        if let listWithUserAnswers = UserDefaultsHandler.shared.onBoardingUserAnswers {
            screens = listWithUserAnswers
        } else {
            screens = OnBoardingScreenType.getDefaultScreensList()
        }
        currentPage = UserDefaultsHandler.shared.currentScreenIndex 
    }
    
    /// Update the user default value indicating that onBoarding flow is done once so that there will be no need to show it again on opening the app
    func updateOnboardingStateInUeserDefaults(isDone: Bool) {
        UserDefaultsHandler.shared.doneOnboarding = isDone
    }
    
    /// Save user choices for next time opening retrieval
    func saveUserChoices() {
        UserDefaultsHandler.shared.onBoardingUserAnswers = screens
    }
}
