//
//  VocabButton.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 30/11/2025.
//

import SwiftUI

struct VocabButton: View {
    // MARK: - Properties
    @State var bottomShadow: CGFloat = 4
    var text: String
    var buttonAction: () -> Void
    
    // MARK: - Drawing View
    var body: some View {
        Text(text)
            .font(.system(size: 18, weight: .heavy))
            .foregroundStyle(.black)
            .addDefaultButtonStyle(
                backgroundColor: .buttonBackground,
                borderColor: .black,
                shadowColor: .black,
                bottomShadow: $bottomShadow
            )
            .addBounceAnimationOnClick(
                bottomShadow: $bottomShadow,
                completion: buttonAction
            )
    }
}

// MARK: - Preview
#Preview {
    VStack {
        Spacer()
        
        VocabButton(text: "Get Started") {}
            .padding(.horizontal, 16)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.viewsBackground)
}
