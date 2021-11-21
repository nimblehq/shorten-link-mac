//
//  User.swift
//  ShortenLink
//
//  Created by Su T. Nguyen on 21/11/2021.
//

import Foundation

protocol User {

    var id: Int { get }
    var userId: Int { get }
    var accessToken: String { get }
    var refreshToken: String { get }
    var accessTokenExpiresAt: String { get }
    var refreshTokenExpiresAt: String { get }
    var createdAt: String { get }
    var updatedAt: String { get }
    var deletedAt: String? { get }
}
