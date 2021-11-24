//
//  RepositoryFactoryProtocol.swift
//  ShortenLink
//
//  Created by Bliss on 15/06/2021.
//

protocol RepositoryFactoryProtocol {

    func shortenedLinkRepository() -> ShortenedLinkRepositoryProtocol
    func loginRepository() -> LoginRepositoryProtocol
    func logOutRepository() -> LogOutRepositoryProtocol
    func userSessionRepository() -> UserSessionRepositoryProtocol
}
