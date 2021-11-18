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
//    var createdAt: Date { get }
//    var updatedAt: Date { get }
    var originalUrl: String { get }
}
