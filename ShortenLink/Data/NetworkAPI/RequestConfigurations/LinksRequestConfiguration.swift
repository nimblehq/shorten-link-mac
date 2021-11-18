//
//  LinksRequestConfiguration.swift
//  ShortenLink
//
//  Created by Bliss on 18/11/21.
//

import Alamofire

enum LinksRequestConfiguration {

    static func create(link: String) -> APIRequestConfiguration<APIShortenLink> {
        APIRequestConfiguration(
            baseURL: "https://nimble-link.herokuapp.com/api/v1/",
            endpoint: "links",
            method: .post,
            encoding: JSONEncoding.default,
            parameters: ["original_url": link]
        )
    }
}

