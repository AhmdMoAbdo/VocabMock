//
//  KeyboardObserver.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 02/12/2025.
//

import SwiftUI
import Combine

@Observable
final class KeyboardObserver {
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    var keyboardHeight: CGFloat = 0
    var isVisible: Bool = false
    
    // MARK: - Initializer
    init() {
        observeKeyboardAppearance()
        observeKeyboardDisappearance()
    }
    
    // MARK: - Keyboard appearance
    private func observeKeyboardAppearance() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
            .map { $0.height }
            .sink { [weak self] height in
                guard let self else { return }
                isVisible = true
                keyboardHeight = height
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Keyboard disappearance
    private func observeKeyboardDisappearance() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { [weak self] _ in
                guard let self else { return }
                isVisible = false
                keyboardHeight = 0
            }
            .store(in: &cancellables)
    }
}
