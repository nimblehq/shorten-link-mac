//
//  KeychainKey.swift
//  ShortenLink
//
//  Created by Su T. Nguyen on 21/11/2021.
//

import Foundation

protocol KeychainKey {}

extension KeychainKey {

    static var user: Keychain.Key<KeychainUser> {
        Keychain.Key(key: "KeychainUser")
    }
}
