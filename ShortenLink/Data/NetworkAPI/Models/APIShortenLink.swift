//
//  APIShortenLink.swift
//  ShortenLink
//
//  Created by Bliss on 18/11/21.
//

import Foundation

struct APIShortenLink: ShortenLink, Decodable {

    var id: Int
    var alias: String
//    var createdAt: Date
//    var updatedAt: Date
    var originalUrl: String
}
