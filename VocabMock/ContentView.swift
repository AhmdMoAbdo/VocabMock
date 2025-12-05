//
//  ContentView.swift
//  VocabMock
//
//  Created by Ahmed Abdo on 30/11/2025.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @State var didDisplayOnBoardingFlow: Bool = false
    private var doneOnboarding: Bool {
        UserDefaultsHandler.shared.doneOnboarding
    }
    
    // MARK: - Drawing View
    var body: some View {
        ZStack {
            if didDisplayOnBoardingFlow || doneOnboarding {
                Home()
            }
            if !doneOnboarding {
                OnboardingScreenView(doneWithOnboarding: $didDisplayOnBoardingFlow)
            }
        }
    }
}
#Preview {
    ContentView()
}
