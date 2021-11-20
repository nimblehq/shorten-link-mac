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
    var createdAt: Date { get }
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
    let createdAt: Date

    init(
        fullLink: String,
        shortenLink: String,
        createdAt: Date
    ) {
        self.fullLink = fullLink
        self.shortenLink = shortenLink
        self.createdAt = createdAt
    }
}
