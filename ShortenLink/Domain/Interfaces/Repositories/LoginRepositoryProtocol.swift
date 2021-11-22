//
//  LoginRepositoryProtocol.swift
//  ShortenLink
//
//  Created by Su T. Nguyen on 21/11/2021.
//

import RxSwift

// sourcery: AutoMockable
protocol LoginRepositoryProtocol: AnyObject {

    func login(with idToken: String) -> Single<User>
}
