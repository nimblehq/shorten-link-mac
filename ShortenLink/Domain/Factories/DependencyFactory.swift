//
//  DependencyFactory.swift
//  ShortenLink
//
//  Created by Su T. Nguyen on 21/11/2021.
//

import Foundation

final class DependencyFactory {

    static let shared = DependencyFactory(
        keychain: Keychain.default,
        networkAPI: NetworkAPI(),
        authenticatedNetworkAPI: AuthenticatedNetworkAPI(keychain: Keychain.default)
    )

    private let keychain: KeychainProtocol
    private let networkAPI: NetworkAPIProtocol
    private let authenticatedNetworkAPI: NetworkAPIProtocol

    init(
        keychain: KeychainProtocol,
        networkAPI: NetworkAPIProtocol,
        authenticatedNetworkAPI: NetworkAPIProtocol
    ) {
        self.keychain = keychain
        self.networkAPI = networkAPI
        self.authenticatedNetworkAPI = authenticatedNetworkAPI
    }
}

// MARK: - Make UseCase

extension DependencyFactory {

    func userUseCase() -> UserUseCaseProtocol {
        UserUseCase(
            loginRepository: loginRepository(),
            userSessionRepository: userSessionRepository()
        )
    }

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
}

// MARK: - Make Repository

extension DependencyFactory {

    func loginRepository() -> LoginRepositoryProtocol {
        LoginRepository(networkAPI: networkAPI)
    }

    func userSessionRepository() -> UserSessionRepositoryProtocol {
        UserSessionRepository(keychain: keychain)
    }

    func shortenedLinkRepository() -> ShortenedLinkRepositoryProtocol {
        ShortenedLinkRepository(networkAPI: authenticatedNetworkAPI)
    }
}
