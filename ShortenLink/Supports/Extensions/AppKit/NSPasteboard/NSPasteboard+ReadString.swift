//
//  NSPasteboard+ReadString.swift
//  ShortenLink
//
//  Created by Bliss on 22/11/21.
//

import AppKit

extension NSPasteboard {

    func readString() -> String? {
        return pasteboardItems?.first?.string(forType: .string)
    }
}
