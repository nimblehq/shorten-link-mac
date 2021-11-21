//
//  UserUseCase.swift
//  ShortenLink
//
//  Created by Su T. Nguyen on 21/11/2021.
//

import RxSwift

// sourcery: AutoMockable
protocol UserUseCaseProtocol: AnyObject {

    func login(with idToken: String) -> Single<User>
}

final class UserUseCase: UserUseCaseProtocol {

    private var loginRepository: LoginRepositoryProtocol

    init(loginRepository: LoginRepositoryProtocol) {
        self.loginRepository = loginRepository
    }

    func login(with idToken: String) -> Single<User> {
        loginRepository.login(with: idToken)
    }
}
