//
//  DeleteShortenLinkUseCase.swift
//  ShortenLink
//
//  Created by Su T. Nguyen on 22/11/2021.
//

import RxSwift

// sourcery: AutoMockable
protocol DeleteShortenLinkUseCaseProtocol: AnyObject {

    func deleteLink(_ linkId: Int) -> Single<Void>
}

final class DeleteShortenLinkUseCase: DeleteShortenLinkUseCaseProtocol {

    private var shortenedLinkRepository: ShortenedLinkRepositoryProtocol

    init(shortenedLinkRepository: ShortenedLinkRepositoryProtocol) {
        self.shortenedLinkRepository = shortenedLinkRepository
    }

    func deleteLink(_ linkId: Int) -> Single<Void> {
        shortenedLinkRepository.delete(linkId)
    }
}
