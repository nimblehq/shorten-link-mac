//
//  NSView+AddSubViews.swift
//  ShortenLink
//
//  Created by Phong Vo on 17/11/2021.
//

import Cocoa

extension NSView {

    func addSubviews(_ subviews: NSView...) {
        subviews.forEach { addSubview($0) }
    }
}
