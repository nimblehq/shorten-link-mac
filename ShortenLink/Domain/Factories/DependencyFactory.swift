//
//  DependencyFactory.swift
//  ShortenLink
//
//  Created by Su T. Nguyen on 21/11/2021.
//

import Foundation

protocol ModuleFactoryProtocol: ViewModelFactoryProtocol, UseCaseFactoryProtocol {}

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

// MARK: - RepositoryFactoryProtocol

extension DependencyFactory: RepositoryFactoryProtocol {

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

// MARK: - ModuleFactoryProtocol

extension DependencyFactory: ModuleFactoryProtocol {}
