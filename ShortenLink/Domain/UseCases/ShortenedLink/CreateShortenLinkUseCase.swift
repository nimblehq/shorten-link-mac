//
//  CreateShortenLinkUseCase.swift
//  ShortenLink
//
//  Created by Bliss on 18/11/21.
//

import RxSwift

// sourcery: AutoMockable
protocol CreateShortenLinkUseCaseProtocol: AnyObject {

    func createLink(
        _ link: String,
        alias: String,
        password: String
    ) -> Single<ShortenLink>
}

final class CreateShortenLinkUseCase: CreateShortenLinkUseCaseProtocol {

    private var shortenedLinkRepository: ShortenedLinkRepositoryProtocol

    init(shortenedLinkRepository: ShortenedLinkRepositoryProtocol) {
        self.shortenedLinkRepository = shortenedLinkRepository
    }

    func createLink(
        _ link: String,
        alias: String,
        password: String = ""
    ) -> Single<ShortenLink> {
        shortenedLinkRepository.create(link, alias: alias, password: password)
    }
}
