//
//  PrimaryButton.swift
//  SwiftUIComponentsKit
//
//  Created by Liz Isasi on 22/11/2025.
//

import SwiftUI

public struct PrimaryButton: View {
    let title: String
    let variant: ButtonVariant
    let height: CGFloat
    let isLoading: Bool
    let isDisabled: Bool
    let action: () -> Void

    public init(
        title: String,
        variant: ButtonVariant = .primary,
        height: CGFloat = 48,
        isLoading: Bool = false,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.variant = variant
        self.height = height
        self.isLoading = isLoading
        self.isDisabled = isDisabled
        self.action = action
    }

    public var body: some View {
        let colors = variant.style
        let shouldDisable = isLoading || isDisabled
        let backgroundColor = shouldDisable ? colors.disabledBackground : colors.background
        let foregroundColor = shouldDisable ? colors.disabledForeground : colors.foreground

        Button {
            guard !shouldDisable else { return }
            action()
        } label: {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView()
                        .tint(foregroundColor)
                }

                Text(title)
                    .foregroundColor(foregroundColor)
                    .font(.headline)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(backgroundColor)
            )
        }
        .disabled(shouldDisable)
    }
}

#if DEBUG
#Preview {
    VStack(spacing: 16) {
        PrimaryButton(title: "Ingresar", variant: .primary) {}
        PrimaryButton(title: "Aceptar", variant: .secondary) {}
        PrimaryButton(title: "Eliminar", variant: .danger) {}
        PrimaryButton(title: "Cancelar", variant: .neutral) {}
        PrimaryButton(title: "Deshabilitado", variant: .primary, isDisabled: true) {}
        PrimaryButton(title: "Cargando…", isLoading: true) {}
    }
    .padding()
}
#endif
