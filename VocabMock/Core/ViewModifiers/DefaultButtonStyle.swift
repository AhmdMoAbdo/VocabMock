//
//  DefaultButtonStyle.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 30/11/2025.
//

import SwiftUI

// MARK: - Extend view to easily apply the default button modifier
extension View {
    func addDefaultButtonStyle(
        width: CGFloat? = .infinity,
        backgroundColor: Color,
        borderColor: Color,
        shadowColor: Color,
        bottomShadow: Binding<CGFloat>
    ) -> some View {
        self.modifier(
            DefaultButtonStyle(
                width: width,
                backgroundColor: backgroundColor,
                borderColor: borderColor,
                shadowColor: shadowColor,
                bottomShadow: bottomShadow
            )
        )
    }
}

// MARK: - Grouping button properties in one modifier
struct DefaultButtonStyle: ViewModifier {
    var width: CGFloat?
    var backgroundColor: Color
    var borderColor: Color
    var shadowColor: Color
    @Binding var bottomShadow: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: width)
            .frame(height: 52)
            .background(backgroundColor)
            .clipShape(.rect(cornerRadius: 24))
            .shadow(color: shadowColor, radius: 0, x: 0, y: bottomShadow)
            .overlay {
                RoundedRectangle(cornerRadius: 24)
                    .stroke(borderColor, lineWidth: 1)
            }
    }
}
