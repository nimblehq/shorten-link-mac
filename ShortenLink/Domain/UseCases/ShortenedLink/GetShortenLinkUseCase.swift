//
//  GetShortenLinkUseCase.swift
//  ShortenLink
//
//  Created by Su T. Nguyen on 22/11/2021.
//

import RxSwift

// sourcery: AutoMockable
protocol GetShortenLinkUseCaseProtocol: AnyObject {

    func getLinks() -> Single<[ShortenLink]>
}

final class GetShortenLinkUseCase: GetShortenLinkUseCaseProtocol {

    private var shortenedLinkRepository: ShortenedLinkRepositoryProtocol

    init(shortenedLinkRepository: ShortenedLinkRepositoryProtocol) {
        self.shortenedLinkRepository = shortenedLinkRepository
    }

    func getLinks() -> Single<[ShortenLink]> {
        shortenedLinkRepository.get()
    }
}
