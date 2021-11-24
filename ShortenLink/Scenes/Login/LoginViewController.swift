//
//  LoginViewController.swift
//  ShortenLink
//
//  Created by Phong Vo on 22/11/2021.
//

import Cocoa
import RxSwift
import RxCocoa

final class LoginViewController: NSViewController {

    private let signInWithGoogleButton = NSButton()
    private let topSeparator = NSBox()
    private let signInContainerBox = NSBox()
    private let googleImageView = NSImageView()
    private let signInGoogleTextField = NSTextField()
    
    private let viewModel: LoginViewModelType!
    private let disposeBag = DisposeBag()

    init(viewModel: LoginViewModelType) {
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
        bindInput()
    }
}

// MARK: - Private functions

extension LoginViewController {

    private func setUpLayout() {
        view.addSubviews(topSeparator, signInContainerBox, signInWithGoogleButton)

        signInContainerBox.addSubviews(googleImageView, signInGoogleTextField)

        topSeparator.snp.makeConstraints {
            $0.centerX.width.top.equalToSuperview()
            $0.height.equalTo(1.0)
        }

        signInWithGoogleButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(20.0)
            $0.size.equalTo(CGSize(width: 300.0, height: 50.0))
        }

        signInContainerBox.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(20.0)
            $0.size.equalTo(CGSize(width: 300.0, height: 50.0))
        }

        signInGoogleTextField.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }

        googleImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 35.0, height: 35.0))
            $0.trailing.equalTo(signInGoogleTextField.snp.leading).inset(-9.0)
        }
    }

    private func setUpViews() {
        signInWithGoogleButton.isBordered = false
        signInWithGoogleButton.title = ""

        topSeparator.boxType = .custom
        topSeparator.borderColor = .clear
        topSeparator.borderWidth = 0.0
        topSeparator.fillColor = NSColor.textColor.withAlphaComponent(0.3)

        signInContainerBox.boxType = .custom
        signInContainerBox.borderColor = NSColor.textColor.withAlphaComponent(0.3)
        signInContainerBox.fillColor = .clear
        signInContainerBox.cornerRadius = 6.0

        signInGoogleTextField.stringValue = L10n.Login.signInWithGoogleAccount
        signInGoogleTextField.font = .systemFont(ofSize: 14.0)
        signInGoogleTextField.isEditable = false
        signInGoogleTextField.isBezeled = false
        signInGoogleTextField.backgroundColor = .clear

        googleImageView.image = Asset.googleIc.image
    }

    private func bindInput() {
        signInWithGoogleButton.rx.tap
            .bind(to: viewModel.input.logInWithGoogleTapped)
            .disposed(by: disposeBag)
    }
}
