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
    let action: () -> Void

    public init(
        title: String,
        variant: ButtonVariant = .primary,
        height: CGFloat = 48,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.variant = variant
        self.height = height
        self.isLoading = isLoading
        self.action = action
    }

    public var body: some View {
        let colors = variant.style

        Button {
            guard !isLoading else { return }
            action()
        } label: {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView()
                        .tint(colors.foreground)
                }

                Text(title)
                    .foregroundColor(colors.foreground)
                    .font(.headline)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(colors.background)
            )
        }
        .disabled(isLoading)
    }
}

#if DEBUG
#Preview {
    VStack(spacing: 16) {
        PrimaryButton(title: "Ingresar", variant: .primary) {}
        PrimaryButton(title: "Aceptar", variant: .secondary) {}
        PrimaryButton(title: "Cerrar sesión", variant: .danger) {}
        PrimaryButton(title: "Cancelar", variant: .neutral) {}
        PrimaryButton(title: "Cargando…", isLoading: false) {}
    }
    .padding()
}
#endif
