//
//  AuthenticatedNetworkAPI.swift
//  ShortenLink
//
//  Created by Su T. Nguyen on 22/11/2021.
//

import Alamofire
import RxSwift

final class AuthenticatedNetworkAPI: NetworkAPIProtocol {

    private let decoder: JSONDecoder
    private let session: Session

    init(
        decoder: JSONDecoder = .main,
        keychain: KeychainProtocol
    ) {
        self.decoder = decoder
        session = Session(interceptor: AuthenticatedInterceptor(keychain: keychain))
    }

    func performRequest<T>(_ configuration: RequestConfiguration, for type: T.Type) -> Single<T> where T: Decodable {
        request(
            session: session,
            configuration: configuration,
            decoder: decoder
        )
    }

    func performRequestWithEmptyResponse(_ configuration: RequestConfiguration) -> Single<Void> {
        requestWithEmptyResponse(
            session: session,
            configuration: configuration
        )
    }
}
