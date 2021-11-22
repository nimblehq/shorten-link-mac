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
            .do(onSuccess: {
                print("User: \($0)")
            }, onError: {
                print("Login repository error:: \($0)")
            })
            .asObservable()
            .withUnretained(self)
            .flatMapLatest { owner, user -> Completable in
                print("Flatmap after login")
                let saveIsLoggedIn = owner.userSessionRepository.saveIsLoggedIn()
                let saveUser = owner.userSessionRepository.saveUser(.init(user: user))
                return saveIsLoggedIn.andThen(saveUser)
            }
            .asCompletable()
    }
}
