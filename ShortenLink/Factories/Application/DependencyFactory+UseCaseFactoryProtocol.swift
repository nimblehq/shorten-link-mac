//
//  DependencyFactory+UseCaseFactoryProtocol.swift
//  ShortenLink
//
//  Created by Bliss on 29/07/2021.
//

extension DependencyFactory: UseCaseFactoryProtocol {

    func createShortenLinkUseCase() -> CreateShortenLinkUseCaseProtocol {
        CreateShortenLinkUseCase(createShortenLinkRepository: createShortenLinkRepository())
    }
}
