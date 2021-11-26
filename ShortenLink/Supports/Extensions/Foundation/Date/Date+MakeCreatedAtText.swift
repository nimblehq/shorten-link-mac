//
//  Date+MakeDisplayText.swift
//  ShortenLink
//
//  Created by Phong Vo on 22/11/2021.
//

import Foundation

extension Date {

    func makeCreatedAtText() -> String {
        let now = Date().timeIntervalSince1970
        let timeStamp = timeIntervalSince1970
        guard now > timeStamp else { return "" }
        let deltaSecs = Int(now - timeStamp)
        // Display in seconds
        if deltaSecs < 60 {
            if deltaSecs == 1 {
                return L10n.Common.aSecondAgo // edge case
            } else {
                return "\(deltaSecs) \(L10n.Common.secondsAgo)"
            }
        }
        // Display in minutes
        let deltaMins = deltaSecs / 60
        if deltaMins == 1 {
            return L10n.Common.aMinuteAgo
        } else if deltaMins < 60 {
            return "\(deltaMins) \(L10n.Common.minutesAgo)"
        }
        // Display in hours
        let deltaHours = deltaMins / 60
        if deltaHours == 1 {
            return L10n.Common.anHourAgo
        } else {
            return "\(deltaHours) \(L10n.Common.hoursAgo)"
        }
    }
}
