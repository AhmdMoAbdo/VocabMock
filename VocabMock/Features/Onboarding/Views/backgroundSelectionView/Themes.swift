//
//  Themes.swift
//  TestCursor
//
//  Created by Ahmed Abdo on 03/12/2025.
//

import Foundation
import SwiftUICore
import DeveloperToolsSupport

// MARK: - Available options for Background/Theme selection
enum Themes: CaseIterable, Codable {
    case theme1
    case theme2
    case theme3
    case theme4
    case theme5
    case theme6
    
    // MARK: - Respective image
    func getRespectiveImage() -> ImageResource {
        switch self {
        case .theme1:
                .theme1Background
            
        case .theme2:
                .theme2Background
            
        case .theme3:
                .theme3Background
            
        case .theme4:
                .theme4Background
            
        case .theme5:
                .theme5Background
            
        case .theme6:
                .theme6Background
        }
    }
    
    // MARK: - Respective font
    func getRespectiveFont(fontSize: CGFloat = 28, fontWeight: Font.Weight? = nil) -> Font {
        switch self {
        case .theme1:
                .system(size: fontSize, weight: fontWeight ?? .bold, design: .default)
            
        case .theme2:
                .system(size: fontSize, weight: fontWeight ?? .bold, design: .serif)
            
        case .theme3:
                .system(size: fontSize, weight: fontWeight ?? .medium, design: .serif)

        case .theme4:
                .system(size: fontSize, weight: fontWeight ?? .bold, design: .rounded)

        case .theme5:
                .system(size: fontSize, weight: fontWeight ?? .regular, design: .monospaced)

        case .theme6:
                .system(size: fontSize, weight: fontWeight ?? .regular, design: .serif)
        }
    }
    
    // MARK: - Respective color
    func getRRespectiveColor() -> Color {
        switch self {
        case .theme1, .theme3, .theme4, .theme6:
                .white
            
        case .theme2, .theme5:
                .black
        }
    }
}
