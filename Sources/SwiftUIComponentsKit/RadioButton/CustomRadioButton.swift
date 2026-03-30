//
//  CustomRadioButton.swift
//  SwiftUIComponentsKit
//
//  Created by Liz Isasi on 29/03/2026.
//

import SwiftUI

public struct CustomRadioButton: View {
    
    let title: String
    let options: [String]
    @Binding var selectedOption: String
    var selectedColor: Color
    var onSelectionChanged: ((String) -> Void)?
    
    public init(
        title: String,
        options: [String],
        selectedOption: Binding<String>,
        selectedColor: Color = .gelatoSecondary,
        onSelectionChanged: ((String) -> Void)? = nil
    ) {
        self.title = title
        self.options = options
        self._selectedOption = selectedOption
        self.selectedColor = selectedColor
        self.onSelectionChanged = onSelectionChanged
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
            
            VStack(spacing: 14) {
                ForEach(options, id: \.self) { option in
                    Button {
                        Self.applySelection(
                            option,
                            selectedOption: &selectedOption,
                            onSelectionChanged: onSelectionChanged
                        )
                    } label: {
                        HStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .stroke(Color.primary, lineWidth: 1.8)
                                    .frame(width: 24, height: 24)
                                
                                if selectedOption == option {
                                    Circle()
                                        .fill(selectedColor)
                                        .frame(width: 12, height: 12)
                                }
                            }
                            
                            Text(option)
                                .font(.body)
                                .foregroundColor(.primary)
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, minHeight: 44, alignment: .leading)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

extension CustomRadioButton {
    static func applySelection(
        _ option: String,
        selectedOption: inout String,
        onSelectionChanged: ((String) -> Void)?
    ) {
        withAnimation(.easeInOut(duration: 0.2)) {
            selectedOption = option
        }
        onSelectionChanged?(option)
    }
}

#Preview {
    RadioPreviewWrapper()
}

private struct RadioPreviewWrapper: View {
    @State private var selected = "Cone"
    
    var body: some View {
        CustomRadioButton(
            title: "Choose your presentation",
            options: ["Cone", "Cup", "1/4 Kg"],
            selectedOption: $selected
        ) { value in
            print("Selected: \(value)")
        }
        .padding()
    }
}
