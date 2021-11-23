//
//  NSPasteboard+SetGeneralString.swift
//  ShortenLink
//
//  Created by Bliss on 22/11/21.
//

import AppKit

extension NSPasteboard {

    func setGeneralString(_ text: String) {
        declareTypes([.string], owner: nil)
        setString(text, forType: .string)
    }
}
