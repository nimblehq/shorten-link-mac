//
//  JSONDecoder+Default.swift
//  ShortenLink
//
//  Created by Bliss on 18/11/21.
//

import Foundation

extension JSONDecoder {

    static let main: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
