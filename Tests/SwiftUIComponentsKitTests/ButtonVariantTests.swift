import XCTest
import SwiftUI
@testable import SwiftUIComponentsKit

final class ButtonVariantTests: XCTestCase {
    func testPrimaryStyleMapping() {
        let style = ButtonVariant.primary.style

        assertColorEquals(style.background, .gelatoPrimary)
        assertColorEquals(style.foreground, .white)
    }

    func testSecondaryStyleMapping() {
        let style = ButtonVariant.secondary.style

        assertColorEquals(style.background, .gelatoSecondary)
        assertColorEquals(style.foreground, .white)
    }

    func testDangerStyleMapping() {
        let style = ButtonVariant.danger.style

        assertColorEquals(style.background, .red.opacity(0.9))
        assertColorEquals(style.foreground, .white)
    }

    func testNeutralStyleMapping() {
        let style = ButtonVariant.neutral.style

        assertColorEquals(style.background, .gelatoNeutral)
        assertColorEquals(style.foreground, .black)
    }
}

private func assertColorEquals(
    _ lhs: Color,
    _ rhs: Color,
    file: StaticString = #filePath,
    line: UInt = #line
) {
    XCTAssertEqual(colorComponents(lhs), colorComponents(rhs), file: file, line: line)
}

private func colorComponents(_ color: Color) -> [CGFloat] {
#if canImport(UIKit)
    let uiColor = UIColor(color)
    guard let components = uiColor.cgColor.components else {
        return []
    }
    return normalized(components: components)
#elseif canImport(AppKit)
    let nsColor = NSColor(color)
    guard let converted = nsColor.usingColorSpace(.deviceRGB),
          let components = converted.cgColor.components else {
        return []
    }
    return normalized(components: components)
#else
    return []
#endif
}

private func normalized(components: [CGFloat]) -> [CGFloat] {
    if components.count == 2 {
        return [components[0], components[0], components[0], components[1]]
    }
    if components.count == 4 {
        return components
    }
    return []
}
