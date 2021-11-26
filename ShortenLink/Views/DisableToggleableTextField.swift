//
//  DisableToggleableTextField.swift
//  ShortenLink
//
//  Created by Bliss on 25/11/21.
//

import AppKit

final class DisableToggleableTextField: NSTextField {

    func setEnable(_ enable: Bool) {
        isEditable = enable
        backgroundColor = enable ? .controlBackgroundColor : .lightGray.withAlphaComponent(0.5)
    }
}
