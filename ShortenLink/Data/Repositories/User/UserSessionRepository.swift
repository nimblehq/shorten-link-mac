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
                observer(try self?.keychain.get(.user) != nil ?.success(true) : .success(false))
            } catch {
                observer(.failure(error))
            }
            return Disposables.create()
        }
    }

    func saveUser(_ user: KeychainUser) -> Completable {
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

    func clear() -> Completable {
        Completable.create { [weak self] observer in
            do {
                try self?.keychain.remove(.user)
            } catch {
                observer(.error(error))
            }
            observer(.completed)
            return Disposables.create()
        }
    }
}
