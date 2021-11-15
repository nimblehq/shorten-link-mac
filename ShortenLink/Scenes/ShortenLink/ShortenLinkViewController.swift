//
//  ShortenLinkViewController.swift
//  ShortenLink
//
//  Created by Bliss on 12/11/21.
//

import Cocoa
import SnapKit

class ShortenLinkViewController: NSViewController {

    private let urlTextField = ClearableTextField()
    private let shortenButton = NSButton()
    private let instructionText = NSText()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpLayout()
        setUpViews()
    }
}

// MARK: - Private

extension ShortenLinkViewController {

    private func setUpLayout() {
        view.addSubview(urlTextField)
        view.addSubview(shortenButton)
        view.addSubview(instructionText)

        urlTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10.0)
            $0.leading.equalToSuperview().inset(10.0)
            $0.width.equalToSuperview().multipliedBy(0.7)
        }

        shortenButton.snp.makeConstraints {
            $0.top.equalTo(urlTextField)
            $0.leading.equalTo(urlTextField.snp.trailing).offset(10.0)
            $0.trailing.equalToSuperview().inset(10.0)
        }

        instructionText.snp.makeConstraints {
            $0.top.equalTo(urlTextField.snp.bottom).offset(10.0)
            $0.leading.trailing.equalToSuperview().inset(10.0)
            $0.height.equalTo(20.0)
        }
    }

    private func setUpViews() {
        urlTextField.placeholderString = L10n.Shortenlink.Urltextfield.placeholder

        shortenButton.bezelStyle = .rounded
        shortenButton.setButtonType(.momentaryPushIn)
        shortenButton.title = L10n.Shortenlink.Shortenbutton.title

        instructionText.string = L10n.Shortenlink.Instructiontext.title
        instructionText.backgroundColor = .clear
        instructionText.isEditable = false
        instructionText.sizeToFit()
    }
}
