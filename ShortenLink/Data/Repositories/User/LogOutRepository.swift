//
//  LogOutRepository.swift
//  ShortenLink
//
//  Created by Su T. Nguyen on 24/11/2021.
//

import RxSwift

final class LogOutRepository: LogOutRepositoryProtocol {

    private var networkAPI: NetworkAPIProtocol

    init(networkAPI: NetworkAPIProtocol) {
        self.networkAPI = networkAPI
    }

    func logOut() -> Completable {
        networkAPI
            .performRequestWithEmptyResponse(AuthRequestConfiguration.logOut)
            .asCompletable()
    }
}
