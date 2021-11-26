//
//  ShortenedLinkRepositoryProtocol.swift
//  ShortenLink
//
//  Created by Bliss on 18/11/21.
//

import RxSwift

// sourcery: AutoMockable
protocol ShortenedLinkRepositoryProtocol: AnyObject {

    func create(
        _ link: String,
        alias: String?,
        password: String
    ) -> Single<ShortenLink>
    func get() -> Single<[ShortenLink]>
    func edit(_ linkId: Int, alias: String, password: String) -> Single<ShortenLink>
    func delete(_ linkId: Int) -> Single<Void>
}

