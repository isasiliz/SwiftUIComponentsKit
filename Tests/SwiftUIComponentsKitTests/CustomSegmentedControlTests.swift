import XCTest
@testable import SwiftUIComponentsKit

final class CustomSegmentedControlTests: XCTestCase {
    func testInitialSelectionIsPreserved() {
        var selected = "Medium"

        XCTAssertEqual(selected, "Medium")
        CustomSegmentedControl.applySelection("Medium", selectedOption: &selected, onSelectionChanged: nil)
        XCTAssertEqual(selected, "Medium")
    }

    func testSelectionChangeUpdatesSelection() {
        var selected = "Small"

        CustomSegmentedControl.applySelection("Large", selectedOption: &selected, onSelectionChanged: nil)

        XCTAssertEqual(selected, "Large")
    }

    func testSelectionChangeCallsCallbackWithSelectedOption() {
        var selected = "Small"
        var callbackValue: String?

        CustomSegmentedControl.applySelection("Medium", selectedOption: &selected) { option in
            callbackValue = option
        }

        XCTAssertEqual(selected, "Medium")
        XCTAssertEqual(callbackValue, "Medium")
    }
}
