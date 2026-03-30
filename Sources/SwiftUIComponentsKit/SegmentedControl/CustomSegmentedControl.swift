//
//  CustomSegmentedControl.swift
//  SwiftUIComponentsKit
//
//  Created by Liz Isasi on 29/03/2026.
//

import SwiftUI

public struct CustomSegmentedControl: View {
    
    let title: String
    let options: [String]
    @Binding var selectedOption: String
    var selectedColor: Color
    var backgroundColor: Color
    var onSelectionChanged: ((String) -> Void)?
    
    public init(
        title: String,
        options: [String],
        selectedOption: Binding<String>,
        selectedColor: Color = .gelatoPrimary,
        backgroundColor: Color = Color.white.opacity(0.35),
        onSelectionChanged: ((String) -> Void)? = nil
    ) {
        self.title = title
        self.options = options
        self._selectedOption = selectedOption
        self.selectedColor = selectedColor
        self.backgroundColor = backgroundColor
        self.onSelectionChanged = onSelectionChanged
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
            
            HStack(spacing: 0) {
                ForEach(options, id: \.self) { option in
                    Button {
                        Self.applySelection(
                            option,
                            selectedOption: &selectedOption,
                            onSelectionChanged: onSelectionChanged
                        )
                    } label: {
                        Text(option)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(selectedOption == option ? .white : .primary)
                            .frame(maxWidth: .infinity)
                            .frame(minHeight: 52)
                            .contentShape(Rectangle())
                            .background(
                                Group {
                                    if selectedOption == option {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(selectedColor)
                                    } else {
                                        Color.clear
                                    }
                                }
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(6)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(backgroundColor)
            )
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

extension CustomSegmentedControl {
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
    SegmentedPreviewWrapper()
}

private struct SegmentedPreviewWrapper: View {
    @State private var selected = "Medium"
    
    var body: some View {
        CustomSegmentedControl(
            title: "Choose a size",
            options: ["Small", "Medium", "Large"],
            selectedOption: $selected
        ) { value in
            print("Selected: \(value)")
        }
        .padding()
    }
}
