//
//  EditShortenLinkUseCase.swift
//  ShortenLink
//
//  Created by Su T. Nguyen on 22/11/2021.
//

import RxSwift

// sourcery: AutoMockable
protocol EditShortenLinkUseCaseProtocol: AnyObject {

    func editLink(_ linkId: Int, alias: String, password: String) -> Single<ShortenLink>
}

final class EditShortenLinkUseCase: EditShortenLinkUseCaseProtocol {

    private var shortenedLinkRepository: ShortenedLinkRepositoryProtocol

    init(shortenedLinkRepository: ShortenedLinkRepositoryProtocol) {
        self.shortenedLinkRepository = shortenedLinkRepository
    }

    func editLink(_ linkId: Int, alias: String, password: String) -> Single<ShortenLink> {
        shortenedLinkRepository.edit(linkId, alias: alias, password: password)
    }
}
