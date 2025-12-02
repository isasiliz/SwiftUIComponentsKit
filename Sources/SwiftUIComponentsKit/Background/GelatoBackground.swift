//
//  GelatoBackground.swift
//  SwiftUIComponentsKit
//
//  Created by Liz Isasi on 01/12/2025.
//
import SwiftUI

public extension LinearGradient {
    static let gelatoBackground = LinearGradient(
        colors: [
            Color.gelatoSecondary.opacity(0.45),
            Color.white
        ],
        startPoint: .top,
        endPoint: .bottom
    )
}
