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
}

final class UserUseCase: UserUseCaseProtocol {

    private let loginRepository: LoginRepositoryProtocol
    private let userSessionRepository: UserSessionRepositoryProtocol

    init(
        loginRepository: LoginRepositoryProtocol,
        userSessionRepository: UserSessionRepositoryProtocol
    ) {
        self.loginRepository = loginRepository
        self.userSessionRepository = userSessionRepository
    }

    func login(with idToken: String) -> Completable {
        loginRepository.login(with: idToken)
            .asObservable()
            .withUnretained(self)
            .flatMapLatest { owner, user -> Completable in
                let saveIsLoggedIn = owner.userSessionRepository.saveIsLoggedIn()
                let saveUser = owner.userSessionRepository.saveToken(.init(user: user))
                return saveIsLoggedIn.andThen(saveUser)
            }
            .asCompletable()
    }
}
