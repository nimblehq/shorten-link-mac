//
//  APIRequestConfiguration.swift
//  ShortenLink
//
//  Created by Bliss on 18/11/21.
//

import Foundation
import Alamofire

struct APIRequestConfiguration<ResponseModel>: RequestConfiguration {

    let baseURL: String
    let endpoint: String
    let method: HTTPMethod
    let encoding: ParameterEncoding
    let parameters: Parameters?
    let headers: HTTPHeaders?
    let interceptor: RequestInterceptor?
    let decode: (JSONDecoder, Data) throws -> ResponseModel

    init(
        baseURL: String,
        endpoint: String,
        method: HTTPMethod,
        encoding: ParameterEncoding,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil,
        decode: @escaping (JSONDecoder, Data) throws -> ResponseModel
    ) {
        self.baseURL = baseURL
        self.endpoint = endpoint
        self.method = method
        self.encoding = encoding
        self.parameters = parameters
        self.headers = headers
        self.interceptor = interceptor
        self.decode = decode
    }

    func url(with baseURL: String) -> URLConvertible {
        let url = URL(string: baseURL)?.appendingPathComponent(endpoint)
        return url?.absoluteString ?? "\(baseURL)\(endpoint)"
    }
}

// MARK: RequestConfiguration - ResponseModel: Decodable

extension APIRequestConfiguration where ResponseModel: Decodable {

    init(
        baseURL: String,
        endpoint: String,
        method: HTTPMethod,
        encoding: ParameterEncoding,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil
    ) {
        self.init(
            baseURL: baseURL,
            endpoint: endpoint,
            method: method,
            encoding: encoding,
            parameters: parameters,
            headers: headers,
            interceptor: interceptor
        ) { decoder, data in
            try decoder.decode(ResponseModel.self, from: data)
        }
    }
}

// MARK: RequestConfiguration - ResponseModel == Void

extension APIRequestConfiguration where ResponseModel == Void {

    init(
        baseURL: String,
        endpoint: String,
        method: HTTPMethod,
        encoding: ParameterEncoding,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil
    ) {
        self.init(
            baseURL: baseURL,
            endpoint: endpoint,
            method: method,
            encoding: encoding,
            parameters: parameters,
            headers: headers,
            interceptor: interceptor
        ) { _, _ in () }
    }
}

