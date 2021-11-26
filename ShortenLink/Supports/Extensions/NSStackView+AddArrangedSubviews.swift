//
//  NSStackView+AddArrangedSubviews.swift
//  ShortenLink
//
//  Created by Bliss on 25/11/21.
//

import Cocoa

extension NSStackView {

    func addArrangedSubviews(_ subviews: NSView...) {
        subviews.forEach { addArrangedSubview($0) }
    }
}
