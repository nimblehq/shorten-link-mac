//
//  NetworkAPI.swift
//

import Alamofire
import Foundation
import RxSwift

final class NetworkAPI: NetworkAPIProtocol {

    private let decoder: JSONDecoder
    private let session: Session

    init(decoder: JSONDecoder = .main) {
        self.decoder = decoder
        session = Session()
    }

    func performRequest<T: Decodable>(_ configuration: RequestConfiguration, for _: T.Type) -> Single<T> {
        request(
            session: session,
            configuration: configuration,
            decoder: decoder
        )
    }

    func performRequestWithEmptyResponse(_ configuration: RequestConfiguration) -> Single<Void> {
        // Impelement if needed
        .just(())
    }
}
