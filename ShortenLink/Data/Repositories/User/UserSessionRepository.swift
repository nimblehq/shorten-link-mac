//
//  UserSessionRepository.swift
//  ShortenLink
//
//  Created by Su T. Nguyen on 21/11/2021.
//

import RxSwift

final class UserSessionRepository: UserSessionRepositoryProtocol {

    private let keychain: KeychainProtocol

    init(keychain: KeychainProtocol) {
        self.keychain = keychain
    }

    func getIsLoggedIn() -> Single<Bool> {
        Single.create { [weak self] observer in
            do {
                let value = try self?.keychain.get(.isLoggedIn) ?? false
                observer(.success(value))
            } catch {
                observer(.failure(error))
            }
            return Disposables.create()
        }
    }

    func saveIsLoggedIn() -> Completable {
        Completable.create { [weak self] observer in
            do {
                try self?.keychain.set(true, for: .isLoggedIn)
            } catch {
                observer(.error(error))
            }
            observer(.completed)
            return Disposables.create()
        }
    }

    func saveToken(_ user: KeychainUser) -> Completable {
        Completable.create { [weak self] observer in
            do {
                try self?.keychain.set(user, for: .user)
            } catch {
                observer(.error(error))
            }
            observer(.completed)
            return Disposables.create()
        }
    }
}
