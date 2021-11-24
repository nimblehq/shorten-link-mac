//
//  DependencyFactory+UseCaseFactoryProtocol.swift
//  ShortenLink
//
//  Created by Bliss on 29/07/2021.
//

extension DependencyFactory: UseCaseFactoryProtocol {

    func createShortenLinkUseCase() -> CreateShortenLinkUseCaseProtocol {
        CreateShortenLinkUseCase(shortenedLinkRepository: shortenedLinkRepository())
    }

    func getShortenLinksUseCase() -> GetShortenLinkUseCaseProtocol {
        GetShortenLinkUseCase(shortenedLinkRepository: shortenedLinkRepository())
    }

    func editShortenLinkUseCase() -> EditShortenLinkUseCaseProtocol {
        EditShortenLinkUseCase(shortenedLinkRepository: shortenedLinkRepository())
    }

    func deleteShortenLinkUseCase() -> DeleteShortenLinkUseCaseProtocol {
        DeleteShortenLinkUseCase(shortenedLinkRepository: shortenedLinkRepository())
    }

    func userUseCase() -> UserUseCaseProtocol {
        UserUseCase(
            loginRepository: loginRepository(),
            userSessionRepository: userSessionRepository()
        )
    }

    func gSignInUseCase() -> GSignInUseCaseProtocol {
        GSignInUseCase()
    }
}
