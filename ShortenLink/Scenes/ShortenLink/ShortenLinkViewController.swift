//
//  ShortenLinkViewController.swift
//  ShortenLink
//
//  Created by Bliss on 12/11/21.
//

import Cocoa
import HotKey
import RxCocoa
import RxSwift
import SnapKit

class ShortenLinkViewController: NSViewController {

    private let urlTextField = ClearableTextField()
    private let shortenButton = NSButton()
    private let instructionText = NSText()
    private let viewModel: ShortenLinkViewModelType

    private let hotKey = HotKey(key: .l, modifiers: [.command, .shift])

    private let disposeBag = DisposeBag()

    init(viewModel: ShortenLinkViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = NSView(frame: NSRect(x: 0.0, y: 0.0, width: 340.0, height: 100.0))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpLayout()
        setUpViews()
        bindInput()
        bindOutput()
        bindKeyboardShortcut()
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
        urlTextField.delegate = self

        shortenButton.bezelStyle = .rounded
        shortenButton.setButtonType(.momentaryPushIn)
        shortenButton.title = L10n.Shortenlink.Shortenbutton.title

        instructionText.string = L10n.Shortenlink.Instructiontext.title
        instructionText.backgroundColor = .clear
        instructionText.isEditable = false
        instructionText.sizeToFit()
    }

    private func bindInput() {
        shortenButton.rx.tap.bind {
            self.viewModel.input.shortenLink(link: self.urlTextField.stringValue)
        }
        .disposed(by: disposeBag)
    }
    
    private func bindOutput() {
        viewModel.output.linkShortenSuccess
            .drive(with: self, onNext: { owner, value in
                guard value else { return }
                owner.urlTextField.stringValue = ""
                owner.view.window?.contentViewController?.toast(
                    message: L10n.Shortenlink.Toast.message
                )
            })
            .disposed(by: disposeBag)
    }

    private func bindKeyboardShortcut() {
        hotKey.keyDownHandler = { [weak self] in
            let clipboardString = NSPasteboard.general.readString()
            guard let self = self,
                  let clipboardString = clipboardString,
                  clipboardString.count > 0 else { return }
            self.viewModel.input.shortenLink(link: clipboardString)
        }
    }
}

extension ShortenLinkViewController: NSTextFieldDelegate {

    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if (commandSelector == #selector(NSResponder.insertNewline(_:))) {
            viewModel.input.shortenLink(link: urlTextField.stringValue)
            return true
        } else {
            return false
        }
    }
}
