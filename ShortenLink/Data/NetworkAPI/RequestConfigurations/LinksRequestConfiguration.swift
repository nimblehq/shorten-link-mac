//
//  LinksRequestConfiguration.swift
//  ShortenLink
//
//  Created by Bliss on 18/11/21.
//

import Alamofire

enum LinksRequestConfiguration {

    case getLinks
    case create(String, String?, String)
    case verify(Int, String)
    case edit(Int, String, String)
    case delete(Int)
}

extension LinksRequestConfiguration: RequestConfiguration {

    var baseURL: String { "\(Constants.API.baseURL)api/v1/" }

    var endpoint: String {
        switch self {
        case .getLinks, .create: return "links"
        case .verify(let linkId, _),
             .edit(let linkId, _, _),
             .delete(let linkId):
            return "links/\(linkId)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getLinks: return .get
        case .create: return .post
        case .verify: return .post
        case .edit: return .patch
        case .delete: return .delete
        }
    }

    var encoding: ParameterEncoding { JSONEncoding.default }

    var parameters: Parameters? {
        switch self {
        case .getLinks, .delete: return nil
        case let .create(originalLink, alias, password):
            var params = [
                "original_url": originalLink,
                "password": password
            ]
            if let alias = alias {
                params["alias"] = alias
            }
            return params
        case .verify(_, let password):
            return ["password": password]
        case let .edit(_, alias, password):
            return [
                "alias": alias,
                "password": password
            ]
        }
    }
}
