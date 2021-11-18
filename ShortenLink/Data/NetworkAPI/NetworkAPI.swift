//
//  NetworkAPI.swift
//

import Alamofire
import Foundation
import JSONMapper
import RxSwift

final class NetworkAPI: NetworkAPIProtocol {

    private let decoder: JSONDecoder

    init(decoder: JSONDecoder = JSONAPIDecoder.default) {
        self.decoder = decoder
    }

    func performRequest<T: Decodable>(_ configuration: RequestConfiguration, for _: T.Type) -> Single<T> {
        request(
            session: Session(),
            configuration: configuration,
            decoder: decoder
        )
    }
}
