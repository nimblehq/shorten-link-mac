//
//  KeychainUser.swift
//  ShortenLink
//
//  Created by Su T. Nguyen on 21/11/2021.
//

import Foundation

struct KeychainUser: User, Codable {

    let id: Int
    let userId: Int
    let accessToken: String
    let refreshToken: String
    let accessTokenExpiresAt: String
    let refreshTokenExpiresAt: String
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?

    init(user: User) {
        id = user.id
        userId = user.userId
        accessToken = user.accessToken
        refreshToken = user.refreshToken
        accessTokenExpiresAt = user.accessTokenExpiresAt
        refreshTokenExpiresAt = user.refreshTokenExpiresAt
        createdAt = user.createdAt
        updatedAt = user.updatedAt
        deletedAt = user.deletedAt
    }
}
