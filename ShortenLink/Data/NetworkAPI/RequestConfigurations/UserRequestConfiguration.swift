//
//  UserRequestConfiguration.swift
//  ShortenLink
//
//  Created by Su T. Nguyen on 21/11/2021.
//

import Alamofire

enum LoginRequestConfiguration {

    case login(String)
}

extension LoginRequestConfiguration: RequestConfiguration {

    var baseURL: String {
        switch self {
        case .login: return Constants.API.baseURL
        }
    }

    var endpoint: String {
        switch self {
        case .login: return "auth/verify_token"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .login: return .post
        }
    }

    var encoding: ParameterEncoding { JSONEncoding.default }

    var parameters: Parameters? {
        switch self {
        case .login(let idToken):
            return [
                "idToken": idToken
            ]
        }
    }
}
