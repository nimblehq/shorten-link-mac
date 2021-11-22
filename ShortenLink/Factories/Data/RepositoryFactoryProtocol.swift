//
//  RepositoryFactoryProtocol.swift
//  ShortenLink
//
//  Created by Bliss on 15/06/2021.
//

protocol RepositoryFactoryProtocol {

    func shortenLinkRepository() -> ShortenedLinkRepositoryProtocol
    func loginRepository() -> LoginRepositoryProtocol
    func userSessionRepository() -> UserSessionRepositoryProtocol
}
