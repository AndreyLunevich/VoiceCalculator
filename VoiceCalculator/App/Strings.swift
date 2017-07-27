// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable file_length
// swiftlint:disable line_length

// swiftlint:disable type_body_length
// swiftlint:disable nesting
// swiftlint:disable variable_name
// swiftlint:disable valid_docs
// swiftlint:disable type_name

enum L10n {
  /// Calculate value of: %@
  static func calculateValue(_ p1: String) -> String {
    return L10n.tr("CALCULATE_VALUE", p1)
  }
  /// Calculated value: %@
  static func calculatedValue(_ p1: String) -> String {
    return L10n.tr("CALCULATED_VALUE", p1)
  }
  /// Start
  static let start = L10n.tr("START")
  /// Stop
  static let stop = L10n.tr("STOP")
  /// Voice Calculator
  static let voiceCalculator = L10n.tr("VOICE_CALCULATOR")
}

extension L10n {
  fileprivate static func tr(_ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}

// swiftlint:enable type_body_length
// swiftlint:enable nesting
// swiftlint:enable variable_name
// swiftlint:enable valid_docs
