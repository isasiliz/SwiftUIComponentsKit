//
//  ButtonStyleConfig.swift
//  SwiftUIComponentsKit
//
//  Created by Liz Isasi on 23/11/2025.
//

import SwiftUI

struct ButtonStyleConfig {
    let background: Color
    let foreground: Color
    let disabledBackground: Color
    let disabledForeground: Color
}

extension ButtonVariant {
    var style: ButtonStyleConfig {
        switch self {
        case .primary:
            return .init(
                background: .gelatoPrimary,
                foreground: .white,
                disabledBackground: .gelatoPrimary.opacity(0.4),
                disabledForeground: .white.opacity(0.8)
            )

        case .secondary:
            return .init(
                background: .gelatoSecondary,
                foreground: .white,
                disabledBackground: .gelatoSecondary.opacity(0.4),
                disabledForeground: .white.opacity(0.8)
            )

        case .danger:
            return .init(
                background: .red.opacity(0.9),
                foreground: .white,
                disabledBackground: .red.opacity(0.35),
                disabledForeground: .white.opacity(0.8)
            )

        case .neutral:
            return .init(
                background: .gelatoNeutral,
                foreground: .black,
                disabledBackground: .gelatoNeutral.opacity(0.5),
                disabledForeground: .black.opacity(0.6)
            )
        }
    }
}
