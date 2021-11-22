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
        networkAPI: NetworkAPI()
    )

    private let keychain: KeychainProtocol
    private let networkAPI: NetworkAPIProtocol

    init(
        keychain: KeychainProtocol,
        networkAPI: NetworkAPIProtocol
    ) {
        self.keychain = keychain
        self.networkAPI = networkAPI
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
}

// MARK: - Make Repository

extension DependencyFactory {

    func loginRepository() -> LoginRepositoryProtocol {
        LoginRepository(networkAPI: networkAPI)
    }

    func userSessionRepository() -> UserSessionRepositoryProtocol {
        UserSessionRepository(keychain: keychain)
    }
}
