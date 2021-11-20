//
//  LinksPopOverViewModel.swift
//  ShortenLink
//
//  Created by Phong Vo on 17/11/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol LinksPopOverViewModelType {

    var input: LinksPopOverViewModelInput { get }
    var output: LinksPopOverViewModelOutput { get }
}

protocol LinksPopOverViewModelOutput {

    var shortenLinks: Driver<[ShortenLinkCellViewModel]> { get }
}

protocol LinksPopOverViewModelInput {

}

final class LinksPopOverViewModel: LinksPopOverViewModelType, LinksPopOverViewModelInput, LinksPopOverViewModelOutput {

    var input: LinksPopOverViewModelInput { self }
    var output: LinksPopOverViewModelOutput { self }

    let shortenLinks: Driver<[ShortenLinkCellViewModel]>

    init() {
        let dummyShortenLinks = [
            ShortenLink(
                fullLink: "http://alonglink.com/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                shortenLink: "https://nimble.link/my-url-12345678",
                createdAt: Date()
            ),
            ShortenLink(
                fullLink: "http://alonglink.com/bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
                shortenLink: "https://nimble.link/my-url-12345678",
                createdAt: Date().addingTimeInterval(TimeInterval(60.0))
            ),
            ShortenLink(
                fullLink: "http://alonglink.com/cccccccccccccccccccccccccccccccccccccccc",
                shortenLink: "https://nimble.link/my-url-12345678",
                createdAt: Date().addingTimeInterval(TimeInterval(3_600.0))
            )
        ].map { ShortenLinkCellViewModel(fullLink: $0.fullLink, shortenLink: $0.shortenLink, createdAt: $0.createdAt) }

        shortenLinks = .just(dummyShortenLinks)
    }
}
