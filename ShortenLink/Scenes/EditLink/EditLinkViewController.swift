//
//  EditLinkViewController.swift
//  ShortenLink
//
//  Created by Bliss on 25/11/21.
//

import AppKit
import RxCocoa
import RxSwift

final class EditLinkViewController: NSViewController {

    private let titleText = NSText()
    private let prefixTextField = NSTextField()
    private let aliasTextField = NSTextField()
    private let privateCheckbox = NSButton(checkboxWithTitle: "", target: nil, action: nil)
    private let passwordTextField = DisableToggleableTextField()
    private let passwordTextFieldContainer = NSView()
    private let linkFieldsView = NSView()
    private let buttonStackView = NSStackView()
    private let saveButton = NSButton()
    private let cancelButton = NSButton()
    private let contentStackView = NSStackView()

    private let viewModel: EditLinkViewModelType

    private let disposeBag = DisposeBag()

    init(viewModel: EditLinkViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = NSView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        setUpViews()
        bindViewModelOutput()
        bindViewModelInput()
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        view.window?.title = L10n.EditLink.Window.title
    }
}

extension EditLinkViewController {

    private func setUpLayout() {
        view.addSubviews(contentStackView)
        contentStackView.addArrangedSubviews(
            titleText,
            linkFieldsView,
            privateCheckbox,
            passwordTextFieldContainer,
            buttonStackView
        )
        linkFieldsView.addSubviews(
            prefixTextField,
            aliasTextField
        )
        passwordTextFieldContainer.addSubview(passwordTextField)
        buttonStackView.addArrangedSubviews(
            NSView(),
            cancelButton,
            saveButton
        )

        titleText.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(20.0)
        }

        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20.0)
        }

        prefixTextField.snp.makeConstraints {
            $0.width.equalTo(view.snp.width).multipliedBy(0.3)
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(22.0)
        }

        aliasTextField.snp.makeConstraints {
            $0.leading.equalTo(prefixTextField.snp.trailing).offset(4.0)
            $0.trailing.top.bottom.equalToSuperview()
        }

        passwordTextField.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(22.0)
        }

        passwordTextFieldContainer.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
    }

    private func setUpViews() {
        contentStackView.spacing = 8.0
        contentStackView.orientation = .vertical
        contentStackView.alignment = .leading

        buttonStackView.spacing = 8.0
        buttonStackView.orientation = .horizontal

        titleText.string = L10n.EditLink.TitleLabel.title
        aliasTextField.placeholderString = L10n.EditLink.AliasTextField.placeholder
        privateCheckbox.title = L10n.EditLink.PrivateButton.title
        passwordTextField.placeholderString = L10n.EditLink.PasswordTextField.placeholder
        cancelButton.title = L10n.EditLink.CancelButton.title
        saveButton.title = L10n.EditLink.SaveButton.title

        titleText.backgroundColor = .clear
        titleText.isEditable = false
        titleText.sizeToFit()

        linkFieldsView.wantsLayer = true
        linkFieldsView.layer?.cornerRadius = 6.0
        linkFieldsView.layer?.backgroundColor = CGColor(gray: 0.8, alpha: 1.0)
        linkFieldsView.layer?.borderColor = CGColor(gray: 1.0, alpha: 0.05)
        linkFieldsView.layer?.borderWidth = 1.0

        aliasTextField.isBezeled = false

        passwordTextField.isBezeled = false
        passwordTextField.setEnable(false)

        passwordTextFieldContainer.wantsLayer = true
        passwordTextFieldContainer.layer?.cornerRadius = 6.0
        passwordTextFieldContainer.layer?.backgroundColor = CGColor(gray: 0.8, alpha: 1.0)
        passwordTextFieldContainer.layer?.borderColor = CGColor(gray: 1.0, alpha: 0.05)
        passwordTextFieldContainer.layer?.borderWidth = 1.0

        prefixTextField.isBezeled = false
        prefixTextField.font = .systemFont(ofSize: NSFont.systemFontSize, weight: .bold)
        prefixTextField.stringValue = Constants.API.shortenedLinkBaseURL
        prefixTextField.isEditable = false
        prefixTextField.backgroundColor = .clear
        prefixTextField.alignment = .right

        saveButton.isHighlighted = true
        saveButton.bezelStyle = .rounded
        saveButton.setButtonType(.momentaryPushIn)

        cancelButton.bezelStyle = .rounded
        cancelButton.setButtonType(.momentaryPushIn)
        cancelButton.target = self
        cancelButton.action = #selector(cancelPress(_:))
    }

    @objc private func cancelPress(_ sender: Any?) {
        closeWindow()
    }

    private func bindViewModelOutput() {
        viewModel.output.linkFullURL.drive(titleText.rx.string).disposed(by: disposeBag)
        viewModel.output.shouldEnableSaveButton.drive(saveButton.rx.isEnabled).disposed(by: disposeBag)
        viewModel.output.editLinkShortenSuccess.drive(
            with: self,
            onNext: { owner, value in
                guard let _ = value else { return }
                owner.closeWindow()
            })
            .disposed(by: disposeBag)
    }

    private func bindViewModelInput() {
        passwordTextField.rx.text
            .bind(to: viewModel.input.passwordText)
            .disposed(by: disposeBag)
        aliasTextField.rx.text
            .bind(to: viewModel.input.aliasText)
            .disposed(by: disposeBag)
        privateCheckbox.rx.state
            .bind(to: viewModel.input.isPasswordOn)
            .disposed(by: disposeBag)
        saveButton.rx.tap
            .bind(to: viewModel.input.editShortLink)
            .disposed(by: disposeBag)
        privateCheckbox.rx.state
            .subscribe(with: self) { owner, value in
                owner.view.window?.endEditing(for: owner.view)
                owner.passwordTextField.setEnable(value == .on)
            }
            .disposed(by: disposeBag)

    }

    private func closeWindow() {
        view.window?.close()
    }
}
