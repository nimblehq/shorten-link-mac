//
//  CreateShortenLinkRepositoryProtocol.swift
//  ShortenLink
//
//  Created by Bliss on 18/11/21.
//

import RxSwift

// sourcery: AutoMockable
protocol CreateShortenLinkRepositoryProtocol: AnyObject {

    func createShortenLink(_ link: String) -> Single<ShortenLink>
}

