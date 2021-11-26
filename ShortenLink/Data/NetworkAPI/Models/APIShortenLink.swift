//
//  APIShortenLink.swift
//  ShortenLink
//
//  Created by Bliss on 18/11/21.
//

import Foundation

struct APIShortenLink: ShortenLink, Decodable {

    let id: Int
    let alias: String
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
    let originalUrl: String
    let password: String
    let counter: Int
    let userId: Int

    var createdAtDate: Date? { createdAt.asDate(using: .iso8601FullGregorian) }
    var updatedAtDate: Date? { updatedAt.asDate(using: .iso8601FullGregorian) }
    var deletedAtDate: Date? { deletedAt?.asDate(using: .iso8601FullGregorian) }
}
