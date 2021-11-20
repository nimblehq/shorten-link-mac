//
//  DateFormatter+Formats.swift
//  DeeMoney
//
//  Created by Su T. Nguyen on 6/24/20.
//  Copyright © 2020 nimble. All rights reserved.
//

import Foundation

extension DateFormatter {

    /// Support full iso8601 conversion.
    /// Formatted to local calendar.
    static let iso8601Full = DateFormatter(with: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ")

    /// Support full iso8601 conversion.
    /// Formatted to Gregorian calendar only.
    static let iso8601FullGregorian: DateFormatter = {
        let formatter = DateFormatter.iso8601Full
        formatter.calendar = Calendar(identifier: .gregorian)
        return formatter
    }()

    /// The instance which is initialized by this initializer
    /// will be change the localization when user changes app's language
    private convenience init(with format: String) {
        self.init()
        dateFormat = format
    }
}
