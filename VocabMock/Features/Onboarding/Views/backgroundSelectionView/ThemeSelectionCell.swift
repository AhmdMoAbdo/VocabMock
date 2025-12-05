//
//  ThemeSelectionCell.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 03/12/2025.
//

import SwiftUI

struct ThemeSelectionCell: View {
    // MARK: - Properties
    @State var offset: CGFloat = 0
    var isSelected: Bool
    var index: Int
    var theme: Themes
    var swipeAction: () -> Void
    var cellWidth = UIScreen.main.bounds.width / 1.5
    var cellHeight = UIScreen.main.bounds.height / 2
    
    // MARK: - Drawing View
    var body: some View {
        ZStack(alignment: .topLeading) {
            ZStack {
                createCellImage()
                createOverlappingText()
            }
            createSelectionIndicatorImage()
        }
        .frame(width: cellWidth, height: cellHeight)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 10)
        .offset(x: offset, y: -(CGFloat(index <= 2 ? index : 2) * 15))
        .rotationEffect(.init(degrees: getRotaion(angle: 8)))
        .simultaneousGesture(
            DragGesture()
                .onChanged({ value in
                    offset = value.translation.width
                })
                .onEnded({ value in
                    handleEndDraggingAction(translation: value.translation.width)
                })
        )
        .onAppear {
            showOffCarousel()
        }
    }
    
    /// Animating the first page to indicate that swiping shuffles the cards for the user
    private func showOffCarousel() {
        if index == 0 {
            withAnimation(.easeInOut(duration: 0.77)) {
                offset = (cellWidth)
            } completion: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeInOut(duration: 0.77)) {
                        offset = 0
                    }
                }
            }
        }
    }
    
    // MARK: - Cell Image
    private func createCellImage() -> some View {
        Image(theme.getRespectiveImage())
            .resizable()
            .frame(width: cellWidth, height: cellHeight)
            .scaledToFill()
            .clipped()
    }
    
    // MARK: - Overlapping text
    private func createOverlappingText() -> some View {
        Text("Aa")
            .font(theme.getRespectiveFont())
            .foregroundStyle(theme.getRRespectiveColor())
    }
    
    // MARK: - Selection indicator
    @ViewBuilder
    private func createSelectionIndicatorImage() -> some View {
        if isSelected {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundStyle(.buttonBackground)
                .padding(.leading, 16)
                .padding(.top, 16)
        }
    }
    
    // MARK: - End Dragging action
    func handleEndDraggingAction(translation: CGFloat) {
        let width = 200.0
        if abs(translation) > width {
            animateToZeroOffset()
        } else if abs(translation) > width / 3 {
            animateToZeroOffset(
                animateOutFirst: true,
                translation: translation,
                withDelay: true
            )
        } else {
            animateToZeroOffset(withSwipeAction: false)
        }
    }
    
    /// Animating the card either to the back of the stack or back in its place
    private func animateToZeroOffset(
        animateOutFirst: Bool = false,
        translation: CGFloat? = nil,
        withDelay: Bool = false,
        withSwipeAction: Bool = true
    ) {
        if let translation, animateOutFirst {
            withAnimation(.easeInOut(duration: 0.3)) {
                offset = (translation > 0 ? 200 + 32 : -200 - 32)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: withDelay ? (.now() + 0.25): .now()) {
            withAnimation(.easeInOut(duration: 0.3)) {
                offset = 0
                if withSwipeAction {
                    swipeAction()
                }
            }
        }
    }
    
    /// Get dragging rotation angle
    func getRotaion(angle: Double) -> Double {
        return (offset / (UIScreen.main.bounds.width - 50)) * angle
    }
}

// MARK: - Preview
#Preview {
    ThemeSelectionCell(
        isSelected: true,
        index: 0,
        theme: .theme1,
        swipeAction: {}
    )
}
