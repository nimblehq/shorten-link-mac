//
//  CreateShortenLinkUseCase.swift
//  ShortenLink
//
//  Created by Bliss on 18/11/21.
//

import RxSwift

// sourcery: AutoMockable
protocol CreateShortenLinkUseCaseProtocol: AnyObject {

    func createShortenLink(_ link: String) -> Single<ShortenLink>
}

final class CreateShortenLinkUseCase: CreateShortenLinkUseCaseProtocol {

    private var createShortenLinkRepository: CreateShortenLinkRepositoryProtocol

    init(createShortenLinkRepository: CreateShortenLinkRepositoryProtocol) {
        self.createShortenLinkRepository = createShortenLinkRepository
    }

    func createShortenLink(_ link: String) -> Single<ShortenLink> {
        createShortenLinkRepository.createShortenLink(link)
    }
}
