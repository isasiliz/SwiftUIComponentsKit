//
//  CustomTextField.swift
//  SwiftUIComponentsKit
//
//  Created by Liz Isasi on 29/03/2026.
//

import SwiftUI
import UIKit

public struct CustomTextField: View {
    
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var minLength: Int?
    var minLengthMessage: String?
    var maxLength: Int?
    var maxLengthMessage: String?
    var enforcesMaxLength: Bool
    var showsClearButton: Bool
    
    var keyboardType: UIKeyboardType
    var textInputAutocapitalization: TextInputAutocapitalization
    var autocorrectionDisabled: Bool
    
    var titleColor: Color
    var fieldBackgroundColor: Color
    var normalBorderColor: Color
    var errorColor: Color
    
    var onAction: ((CustomTextFieldAction) -> Void)?
    
    @FocusState private var isFocused: Bool
    @State private var hasEdited = false
    
    public init(
        title: String,
        placeholder: String,
        text: Binding<String>,
        minLength: Int? = nil,
        minLengthMessage: String? = nil,
        maxLength: Int? = nil,
        maxLengthMessage: String? = nil,
        enforcesMaxLength: Bool = true,
        showsClearButton: Bool = false,
        keyboardType: UIKeyboardType = .default,
        textInputAutocapitalization: TextInputAutocapitalization = .sentences,
        autocorrectionDisabled: Bool = false,
        titleColor: Color = .primary,
        fieldBackgroundColor: Color = .white,
        normalBorderColor: Color = .gray.opacity(0.4),
        errorColor: Color = .red,
        onAction: ((CustomTextFieldAction) -> Void)? = nil
    ) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
        self.minLength = minLength
        self.minLengthMessage = minLengthMessage
        self.maxLength = maxLength
        self.maxLengthMessage = maxLengthMessage
        self.enforcesMaxLength = enforcesMaxLength
        self.showsClearButton = showsClearButton
        self.keyboardType = keyboardType
        self.textInputAutocapitalization = textInputAutocapitalization
        self.autocorrectionDisabled = autocorrectionDisabled
        self.titleColor = titleColor
        self.fieldBackgroundColor = fieldBackgroundColor
        self.normalBorderColor = normalBorderColor
        self.errorColor = errorColor
        self.onAction = onAction
    }
    
    private var validationMessage: String? {
        Self.validationMessage(
            text: text,
            hasEdited: hasEdited,
            minLength: minLength,
            minLengthMessage: minLengthMessage,
            maxLength: maxLength,
            maxLengthMessage: maxLengthMessage,
            enforcesMaxLength: enforcesMaxLength
        )
    }
    
    private var currentBorderColor: Color {
        validationMessage == nil ? normalBorderColor : errorColor
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(titleColor)
            
            HStack(spacing: 8) {
                TextField(placeholder, text: $text)
                    .textInputAutocapitalization(textInputAutocapitalization)
                    .autocorrectionDisabled(autocorrectionDisabled)
                    .focused($isFocused)
                    .onChange(of: isFocused) { _, newValue in
                        if newValue {
                            onAction?(.beginEditing)
                        } else {
                            hasEdited = true
                            onAction?(.resignFirstResponder)
                        }
                    }
                    .onChange(of: text) { _, newValue in
                        hasEdited = true

                        text = Self.enforcedText(
                            for: newValue,
                            maxLength: maxLength,
                            enforcesMaxLength: enforcesMaxLength
                        )

                        onAction?(.textDidChange(text))
                    }
                    .onSubmit {
                        hasEdited = true
                        onAction?(.commit)
                    }
#if canImport(UIKit)
                    .keyboardType(keyboardType)
#endif
                
                if Self.shouldShowClearButton(showsClearButton: showsClearButton, isFocused: isFocused, text: text) {
                    Button {
                        text = ""
                        hasEdited = true
                        onAction?(.textDidChange(text))
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
            .background(fieldBackgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(currentBorderColor, lineWidth: 1)
            )
            .cornerRadius(8)
            
            if let validationMessage {
                Text(validationMessage)
                    .font(.caption)
                    .foregroundColor(errorColor)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

extension CustomTextField {
    static func enforcedText(
        for newValue: String,
        maxLength: Int?,
        enforcesMaxLength: Bool
    ) -> String {
        guard let maxLength, enforcesMaxLength, newValue.count > maxLength else {
            return newValue
        }
        return String(newValue.prefix(maxLength))
    }

    static func validationMessage(
        text: String,
        hasEdited: Bool,
        minLength: Int?,
        minLengthMessage: String?,
        maxLength: Int?,
        maxLengthMessage: String?,
        enforcesMaxLength: Bool
    ) -> String? {
        if let minLength, hasEdited, !text.isEmpty, text.count < minLength {
            return minLengthMessage ?? "Please enter at least \(minLength) characters."
        }

        if let maxLength, !enforcesMaxLength, text.count > maxLength {
            return maxLengthMessage ?? "Please enter no more than \(maxLength) characters."
        }

        return nil
    }

    static func shouldShowClearButton(
        showsClearButton: Bool,
        isFocused: Bool,
        text: String
    ) -> Bool {
        showsClearButton && isFocused && !text.isEmpty
    }
}

#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State private var text = ""
    
    var body: some View {
        CustomTextField(
            title: "Custom TextField",
            placeholder: "Enter text",
            text: $text,
            minLength: 3,
            minLengthMessage: "Galicia wants more than three characters",
            maxLength: 10,
            maxLengthMessage: "Galicia prefers shorter text",
            enforcesMaxLength: true,
            showsClearButton: true,
            keyboardType: .emailAddress,
            textInputAutocapitalization: .never,
            autocorrectionDisabled: true,
            titleColor: .primary
        ) { action in
            print(action)
        }
    }
}
