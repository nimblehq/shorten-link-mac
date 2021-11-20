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
    var createdAt: String
    var updatedAt: String
    var originalUrl: String

    var createdAtDate: Date? { createdAt.asDate(using: .iso8601FullGregorian) }
    var updatedAtDate: Date? { updatedAt.asDate(using: .iso8601FullGregorian) }
}
