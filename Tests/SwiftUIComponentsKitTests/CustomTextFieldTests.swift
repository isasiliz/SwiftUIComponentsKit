import XCTest
@testable import SwiftUIComponentsKit

final class CustomTextFieldTests: XCTestCase {
    func testEnforcedTextTrimsToMaxLengthWhenEnabled() {
        let result = CustomTextField.enforcedText(for: "123456", maxLength: 4, enforcesMaxLength: true)

        XCTAssertEqual(result, "1234")
    }

    func testValidationMessageForMinLengthAfterEditing() {
        let message = CustomTextField.validationMessage(
            text: "ab",
            hasEdited: true,
            minLength: 3,
            minLengthMessage: nil,
            maxLength: nil,
            maxLengthMessage: nil,
            enforcesMaxLength: true
        )

        XCTAssertEqual(message, "Please enter at least 3 characters.")
    }

    func testShouldShowClearButtonOnlyWhenFocusedAndTextExists() {
        XCTAssertTrue(CustomTextField.shouldShowClearButton(showsClearButton: true, isFocused: true, text: "Hi"))
        XCTAssertFalse(CustomTextField.shouldShowClearButton(showsClearButton: true, isFocused: false, text: "Hi"))
        XCTAssertFalse(CustomTextField.shouldShowClearButton(showsClearButton: true, isFocused: true, text: ""))
    }
}
