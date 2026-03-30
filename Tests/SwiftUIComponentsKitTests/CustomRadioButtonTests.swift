import XCTest
@testable import SwiftUIComponentsKit

@MainActor
final class CustomRadioButtonTests: XCTestCase {
    func testInitialSelectionIsPreserved() {
        var selected = "Cone"

        XCTAssertEqual(selected, "Cone")
        CustomRadioButton.applySelection("Cone", selectedOption: &selected, onSelectionChanged: nil)
        XCTAssertEqual(selected, "Cone")
    }

    func testSelectionChangeUpdatesSelection() {
        var selected = "Cone"

        CustomRadioButton.applySelection("Cup", selectedOption: &selected, onSelectionChanged: nil)

        XCTAssertEqual(selected, "Cup")
    }

    func testSelectionChangeCallsCallbackWithSelectedOption() {
        var selected = "Cone"
        var callbackValue: String?

        CustomRadioButton.applySelection("1/4 Kg", selectedOption: &selected) { option in
            callbackValue = option
        }

        XCTAssertEqual(selected, "1/4 Kg")
        XCTAssertEqual(callbackValue, "1/4 Kg")
    }
}
