//
//  BackButton.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 30/11/2025.
//

import SwiftUI

struct BackButton: View {
    // MARK: - Properties
    @State var shadow: CGFloat = 2
    var backButtonAction: () -> Void
    
    // MARK: - Views
    /// Chevron image
    private var chevronImage: some View {
        Image(systemName: "chevron.left")
            .foregroundColor(.black)
            .font(.system(size: 20, weight: .medium))
    }
    
    /// Containing circle with shadow
    private var backButtonCircle: some View {
        Circle()
            .foregroundStyle(.buttonBackground)
            .frame(width: 40, height: 40)
            .shadow(
                color: .black,
                radius: 0,
                x: 0,
                y: shadow
            )
            .overlay {
                Circle()
                    .stroke(.black, lineWidth: 1)
            }
    }
    
    // MARK: - Drawing View
    var body: some View {
        ZStack {
            backButtonCircle
            chevronImage
        }
        .addBounceAnimationOnClick(
            bottomShadow: $shadow,
            completion: backButtonAction
        )
    }
}

// MARK: - Preview
#Preview {
    BackButton(backButtonAction: {})
}
