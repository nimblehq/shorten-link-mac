//
//  AuthenticationInterceptor.swift
//  ShortenLink
//
//  Created by Su T. Nguyen on 22/11/2021.
//

import Foundation
import Alamofire

final class AuthenticatedInterceptor: RequestInterceptor {

    private let keychain: KeychainProtocol

    init(keychain: KeychainProtocol) {
        self.keychain = keychain
    }

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        if let user = try? keychain.get(.user) {
            request.headers.add(name: "Authorization", value: "Bearer \(user.accessToken)")
            completion(.success(request))
        } else {
            completion(.failure(NetworkAPIError.generic))
        }
    }
}
