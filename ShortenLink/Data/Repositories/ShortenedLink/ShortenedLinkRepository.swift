//
//  ShortenedLinkRepository.swift
//  ShortenLink
//
//  Created by Bliss on 18/11/21.
//

import RxSwift

final class ShortenedLinkRepository: ShortenedLinkRepositoryProtocol {

    private var networkAPI: NetworkAPIProtocol

    init(networkAPI: NetworkAPIProtocol) {
        self.networkAPI = networkAPI
    }

    func create(
        _ link: String,
        alias: String?,
        password: String
    ) -> Single<ShortenLink> {
        networkAPI
            .performRequest(
                LinksRequestConfiguration.create(link, alias, password),
                for: APIShortenLink.self
            )
            .map { $0 as ShortenLink }
    }

    func get() -> Single<[ShortenLink]> {
        networkAPI
            .performRequest(
                LinksRequestConfiguration.getLinks,
                for: [APIShortenLink].self
            )
            .map { $0 as [ShortenLink] }
    }

    func verify(_ linkId: Int, password: String) -> Single<ShortenLink> {
        networkAPI
            .performRequest(
                LinksRequestConfiguration.verify(linkId, password),
                for: APIShortenLink.self
            )
            .map { $0 as ShortenLink }
    }

    func edit(_ linkId: Int, alias: String, password: String) -> Single<ShortenLink> {
        networkAPI
            .performRequest(
                LinksRequestConfiguration.edit(linkId, alias, password),
                for: APIShortenLink.self
            )
            .map { $0 as ShortenLink }
    }

    func delete(_ linkId: Int) -> Single<Void> {
        networkAPI
            .performRequestWithEmptyResponse(
                LinksRequestConfiguration.delete(linkId)
            )
            .mapToVoid()
    }
}
