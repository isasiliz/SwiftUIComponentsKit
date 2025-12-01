//
//  ButtonStyleConfig.swift
//  SwiftUIComponentsKit
//
//  Created by Liz Isasi on 23/11/2025.
//

import SwiftUI

public struct ButtonStyleConfig {
    let background: Color
    let foreground: Color
}

public extension ButtonVariant {
    var style: ButtonStyleConfig {
        switch self {
        case .primary:
            return .init(background: .gelatoPrimary, foreground: .white)

        case .secondary:
            return .init(background: .gelatoSecondary, foreground: .white)

        case .danger:
            return .init(background: .red.opacity(0.9), foreground: .white)

        case .neutral:
            return .init(background: .gelatoNeutral, foreground: .black)
        }
    }
}
