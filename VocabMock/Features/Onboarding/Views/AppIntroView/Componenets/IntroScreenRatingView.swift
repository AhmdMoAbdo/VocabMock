//
//  IntroScreenRatingView.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 01/12/2025.
//

import SwiftUI

struct IntroScreenRatingView: View {
    // MARK: - Drawing View
    var body: some View {
        HStack(spacing: 6) {
            makeLaurelImage(isLeading: true)
            makeRatingView()
            makeLaurelImage(isLeading: false)
        }
    }
    
    // MARK: - Laurel Image
    private func makeLaurelImage(isLeading: Bool) -> some View {
        Image(systemName: isLeading ? "laurel.leading" : "laurel.trailing")
            .resizable()
            .frame(width: 15, height: 50)
            .offset(y: 4)
    }
    
    // MARK: - Rating View
    private func makeRatingView() -> some View {
        VStack(spacing: 2) {
            Text("4.8")
                .font(.system(size: 28, weight: .heavy, design: .serif))
                .foregroundColor(.primary)
            
            HStack(spacing: 4) {
                ForEach(0..<5, id: \.self) { _ in
                    makeStarImage()
                }
            }
        }
    }
    
    // MARK: - Rating star image
    private func makeStarImage() -> some View {
        Image(systemName: "star.fill")
            .resizable()
            .frame(width: 10, height: 10)
            .scaledToFill()
            .foregroundStyle(.yellow)
    }
}

// MARK: - Preview
#Preview {
    IntroScreenRatingView()
}
