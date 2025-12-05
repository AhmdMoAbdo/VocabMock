//
//  RadioButton.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 30/11/2025.
//

import SwiftUI

struct RadioButton: View {
    // MARK: - Properties
    var isSelected: Bool
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - Drawing View
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 20, height: 20)
                .foregroundColor(colorScheme == .light || isSelected ? .white : .clear)
            
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 2))
                .frame(width: 20, height: 20)
                .foregroundStyle(colorScheme == .dark && isSelected ? .dark : .radioButton)
            
            if isSelected {
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(colorScheme == .dark && isSelected ? .dark : .radioButton)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    RadioButton(isSelected: true)
}
