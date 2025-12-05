//
//  ButtonBounceAnimation.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 01/12/2025.
//

import SwiftUI

// MARK: - Extend view to easily apply the bounuce modifier
extension View {
    func addBounceAnimationOnClick(
        bottomShadow: Binding<CGFloat>,
        completion: @escaping () -> Void
    ) -> some View {
        modifier(
            ButtonBounceAnimation(
                bottomShadow: bottomShadow,
                bounceCompletionAction: completion
            )
        )
    }
}

// MARK: - Grouping bounce effect in one modifier
struct ButtonBounceAnimation: ViewModifier {
    @Binding var bottomShadow: CGFloat
    var initialBottomShadow: CGFloat
    var bounceCompletionAction: (() -> Void)
    
    // MARK: - Initializer(s)
    init(bottomShadow: Binding<CGFloat>, bounceCompletionAction: @escaping () -> Void) {
        _bottomShadow = bottomShadow
        initialBottomShadow = bottomShadow.wrappedValue
        self.bounceCompletionAction = bounceCompletionAction
    }
    
    // MARK: - Adding modifiers
    func body(content: Content) -> some View {
        content
            .offset(y: -bottomShadow)
            .onTapGesture {
                withAnimation(.linear(duration: 0.1)) {
                    bottomShadow = 0
                } completion: {
                    withAnimation(.linear(duration: 0.1)) {
                        bottomShadow = initialBottomShadow
                        bounceCompletionAction()
                    }
                }
            }
    }
}
