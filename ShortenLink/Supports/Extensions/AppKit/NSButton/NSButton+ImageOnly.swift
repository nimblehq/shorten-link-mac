//
//  NSButton+ImageOnly.swift
//  ShortenLink
//
//  Created by Bliss on 24/11/21.
//

import AppKit

extension NSButton {

    func imageOnly(image: NSImage?) {
        self.image = image
        self.bezelStyle = .shadowlessSquare
        self.isBordered = false
        self.imagePosition = .imageOnly
    }
}
