//
//  LayoutUtility.swift
//  ShortenLink
//
//  Created by Phong Vo on 18/11/2021.
//

import Cocoa

enum LayoutUtility {

    static func disableTranslateAutoresizingMaskIntoConstraints(for views: NSView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
