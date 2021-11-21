//
//  UserSessionRepositoryProtocol.swift
//  ShortenLink
//
//  Created by Su T. Nguyen on 21/11/2021.
//

import RxSwift

// sourcery: AutoMockable
protocol UserSessionRepositoryProtocol: AnyObject {

    func getIsLoggedIn() -> Single<Bool>
    func saveIsLoggedIn() -> Completable
    func saveToken(_ token: KeychainUser) -> Completable
}
