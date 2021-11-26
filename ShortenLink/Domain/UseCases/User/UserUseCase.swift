//
//  UserUseCase.swift
//  ShortenLink
//
//  Created by Su T. Nguyen on 21/11/2021.
//

import RxSwift

// sourcery: AutoMockable
protocol UserUseCaseProtocol: AnyObject {

    func login(with idToken: String) -> Completable
    func logOut() -> Completable
    func checkUserLoggedIn() -> Single<Bool>
    func clearUserSession() -> Completable
}

final class UserUseCase: UserUseCaseProtocol {

    private let loginRepository: LoginRepositoryProtocol
    private let userSessionRepository: UserSessionRepositoryProtocol
    private let logOutRepository: LogOutRepositoryProtocol

    init(
        loginRepository: LoginRepositoryProtocol,
        userSessionRepository: UserSessionRepositoryProtocol,
        logOutRepository: LogOutRepositoryProtocol
    ) {
        self.loginRepository = loginRepository
        self.userSessionRepository = userSessionRepository
        self.logOutRepository = logOutRepository
    }

    func login(with idToken: String) -> Completable {
        loginRepository.login(with: idToken)
            .asObservable()
            .withUnretained(self)
            .flatMapLatest { owner, user in
                owner.userSessionRepository.saveUser(.init(user: user))
            }
            .asCompletable()
    }

    func checkUserLoggedIn() -> Single<Bool> {
        userSessionRepository.getIsLoggedIn()
    }

    func logOut() -> Completable {
        logOutRepository.logOut()
    }

    func clearUserSession() -> Completable {
        userSessionRepository.clear()
    }
}
