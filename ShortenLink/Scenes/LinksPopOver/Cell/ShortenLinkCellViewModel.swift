//
//  ShortenLinkCellViewModel.swift
//  ShortenLink
//
//  Created by Phong Vo on 18/11/2021.
//

import RxSwift
import RxCocoa

protocol ShortenLinkCellViewModelType {

    var input: ShortenLinkCellViewModelInput { get }
    var output: ShortenLinkCellViewModelOutput { get }
}

protocol ShortenLinkCellViewModelInput {

    var editLinkTapped: PublishRelay<Void> { get }
    var deleteLinkTapped: PublishRelay<Void> { get }
}

protocol ShortenLinkCellViewModelOutput {

    var fullLink: String { get }
    var shortenLink: String { get }
    var createdAt: String { get }
}

final class ShortenLinkCellViewModel: ShortenLinkCellViewModelType,
                                      ShortenLinkCellViewModelInput,
                                      ShortenLinkCellViewModelOutput {

    var input: ShortenLinkCellViewModelInput { self }
    var output: ShortenLinkCellViewModelOutput { self }

    let editLinkTapped = PublishRelay<Void>()
    let deleteLinkTapped = PublishRelay<Void>()

    let fullLink: String
    let shortenLink: String
    var createdAt: String {
        makeCreatedAtText(createdDate)
    }
    private let createdDate: Date

    init(
        fullLink: String,
        shortenLink: String,
        createdAt: Date
    ) {
        self.fullLink = fullLink
        self.shortenLink = shortenLink
        createdDate = createdAt
    }

    private func makeCreatedAtText(_ date: Date) -> String {
        let now = Date().timeIntervalSince1970
        let timeStamp = date.timeIntervalSince1970
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
