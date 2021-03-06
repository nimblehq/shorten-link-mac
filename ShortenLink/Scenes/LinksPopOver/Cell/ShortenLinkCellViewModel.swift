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

    var id: Int { get }
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

    let id: Int
    let fullLink: String
    let shortenLink: String
    var createdAt: String {
        createdDate.makeCreatedAtText()
    }
    private let createdDate: Date

    init(
        id: Int,
        fullLink: String,
        shortenLink: String,
        createdAt: Date
    ) {
        self.id = id
        self.fullLink = fullLink
        self.shortenLink = shortenLink
        createdDate = createdAt
    }
}
