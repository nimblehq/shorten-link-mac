//
//  ClearableTextField.swift
//  ShortenLink
//
//  Created by Bliss on 12/11/21.
//

import Cocoa

class ClearableTextField: NSTextField {

    private let clearButton = NSButton()
    
    override func layout() {
        super.layout()
        setUpLayout()
        setUpViews()
    }

    private func setUpLayout() {
        addSubview(clearButton)
        clearButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(4.0)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(clearButton.snp.height)
            $0.width.equalTo(14.0)
        }
    }

    private func setUpViews() {
        clearButton.bezelStyle = .inline
        clearButton.image = Asset.clear.image
        clearButton.action = #selector(clear)
    }

    @objc private func clear() {
        self.stringValue = ""
    }
}
