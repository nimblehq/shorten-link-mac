//
//  UserRequestConfiguration.swift
//  ShortenLink
//
//  Created by Su T. Nguyen on 21/11/2021.
//

import Alamofire

enum AuthRequestConfiguration {

    case logIn(String)
    case logOut
}

extension AuthRequestConfiguration: RequestConfiguration {

    var baseURL: String { Constants.API.baseURL }

    var endpoint: String {
        switch self {
        case .logIn: return "auth/verify_token"
        case .logOut: return "auth/logout"
        }
    }

    var method: HTTPMethod { .post }

    var encoding: ParameterEncoding { JSONEncoding.default }

    var parameters: Parameters? {
        switch self {
        case .logIn(let idToken):
            return [
                "idToken": idToken
            ]
        case .logOut: return nil
        }
    }
}
