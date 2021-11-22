//
//  ShortenLink.swift
//  ShortenLink
//
//  Created by Bliss on 18/11/21.
//

import Foundation

protocol ShortenLink {

    var id: Int { get }
    var alias: String { get }
    var createdAtDate: Date? { get }
    var updatedAtDate: Date? { get }
    var deletedAtDate: Date? { get }
    var originalUrl: String { get }
    var password: String { get }
    var counter: Int { get }
    var userId: Int { get }
}
