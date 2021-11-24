//
//  LogOutRepositoryProtocol.swift
//  ShortenLink
//
//  Created by Su T. Nguyen on 24/11/2021.
//

import RxSwift

// sourcery: AutoMockable
protocol LogOutRepositoryProtocol: AnyObject {

    func logOut() -> Completable
}
