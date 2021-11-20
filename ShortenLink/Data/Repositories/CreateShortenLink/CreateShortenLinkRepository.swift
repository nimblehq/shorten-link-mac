//
//  CreateShortenLinkRepository.swift
//  ShortenLink
//
//  Created by Bliss on 18/11/21.
//

import RxSwift

final class CreateShortenLinkRepository: CreateShortenLinkRepositoryProtocol {

    private var networkAPI: NetworkAPIProtocol

    init(networkAPI: NetworkAPIProtocol) {
        self.networkAPI = networkAPI
    }

    func createShortenLink(_ link: String) -> Single<ShortenLink> {
        networkAPI
            .performRequest(LinksRequestConfiguration.create(link: link), for: APIShortenLink.self)
            .map { $0 as ShortenLink }
    }
}
