//
//  DependencyFactory.swift
//  ShortenLink
//
//  Created by Bliss on 27/07/2021.
//

protocol ModuleFactoryProtocol: ViewModelFactoryProtocol, UseCaseFactoryProtocol {}

final class DependencyFactory {
    
    private let networkAPI: NetworkAPIProtocol

    init(networkAPI: NetworkAPIProtocol) {
        self.networkAPI = networkAPI
    }
}

// MARK: - RepositoryFactoryProtocol

extension DependencyFactory: RepositoryFactoryProtocol {

    func createShortenLinkRepository() -> CreateShortenLinkRepositoryProtocol {
        CreateShortenLinkRepository(networkAPI: networkAPI)
    }
}

// MARK: - ModuleFactoryProtocol

extension DependencyFactory: ModuleFactoryProtocol {}
