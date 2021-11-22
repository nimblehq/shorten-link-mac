//
//  LoginRepository.swift
//  ShortenLink
//
//  Created by Su T. Nguyen on 21/11/2021.
//

import RxSwift

final class LoginRepository: LoginRepositoryProtocol {

    private var networkAPI: NetworkAPIProtocol

    init(networkAPI: NetworkAPIProtocol) {
        self.networkAPI = networkAPI
    }

    func login(with idToken: String) -> Single<User> {
        networkAPI
            .performRequest(LoginRequestConfiguration.login(idToken), for: APIUser.self)
            .map { $0 as User }
    }
}
