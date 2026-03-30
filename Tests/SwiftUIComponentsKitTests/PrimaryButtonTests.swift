import XCTest
@testable import SwiftUIComponentsKit

@MainActor
final class PrimaryButtonTests: XCTestCase {
    func testLoadingStateDisablesButton() {
        XCTAssertTrue(PrimaryButton.shouldDisable(isLoading: true, isDisabled: false))
    }

    func testDisabledStateDisablesButton() {
        XCTAssertTrue(PrimaryButton.shouldDisable(isLoading: false, isDisabled: true))
    }

    func testShouldDisableUsesLoadingOrDisabled() {
        XCTAssertTrue(PrimaryButton.shouldDisable(isLoading: true, isDisabled: true))
        XCTAssertFalse(PrimaryButton.shouldDisable(isLoading: false, isDisabled: false))
    }
}
