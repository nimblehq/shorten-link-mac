//
//  JSONAPIDecoder+Default.swift
//  ShortenLink
//
//  Created by Bliss on 18/11/21.
//

import JSONMapper

extension JSONAPIDecoder {

    static let `default`: JSONAPIDecoder = {
        let decoder = JSONAPIDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
