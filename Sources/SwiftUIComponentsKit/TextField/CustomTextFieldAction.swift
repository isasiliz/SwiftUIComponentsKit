//
//  CustomTextFieldAction.swift
//  SwiftUIComponentsKit
//
//  Created by Liz Isasi on 29/03/2026.
//

import Foundation

public enum CustomTextFieldAction {
    case beginEditing
    case textDidChange(String)
    case commit
    case resignFirstResponder
}
