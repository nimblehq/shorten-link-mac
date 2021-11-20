//
//  ShortenLinkCellView.swift
//  ShortenLink
//
//  Created by Phong Vo on 18/11/2021.
//

import Cocoa
import RxSwift
import RxCocoa

final class ShortenLinkCellView: NSTableCellView {

    private let fullLinkText = NSText()
    private let shortenLinkText = NSText()
    private let timeStampText = NSText()
    private let editLinkButton = NSButton()
    private let deleteLinkButton = NSButton()
    private var disposeBag = DisposeBag()

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setUpLayout()
        setUpViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func prepareForReuse() {
        disposeBag = DisposeBag()
        super.prepareForReuse()
    }

    func configure(with viewModel: ShortenLinkCellViewModelType) {
        editLinkButton.rx.tap
            .bind(to: viewModel.input.editLinkTapped)
            .disposed(by: disposeBag)

        deleteLinkButton.rx.tap
            .bind(to: viewModel.input.deleteLinkTapped)
            .disposed(by: disposeBag)

        fullLinkText.string = viewModel.output.fullLink
        shortenLinkText.string = viewModel.output.shortenLink

    }
}

// MARK: - Private functions

extension ShortenLinkCellView {

    private func setUpLayout() {
        addSubviews(
            fullLinkText,
            shortenLinkText,
            timeStampText,
            editLinkButton,
            deleteLinkButton
        )
        LayoutUtility.disableTranslateAutoresizingMaskIntoConstraints(
            for: fullLinkText,
            shortenLinkText,
            timeStampText,
            editLinkButton,
            deleteLinkButton
        )

        shortenLinkText.snp.makeConstraints {
            $0.leading.equalTo(self).inset(9.0)
            $0.top.equalTo(self).inset(10.0)
        }

        fullLinkText.snp.makeConstraints {
            $0.leading.equalTo(self).inset(9.0)
            $0.top.equalTo(shortenLinkText.snp.bottom).inset(3.0)
        }

        timeStampText.snp.makeConstraints {
            $0.leading.equalTo(self).inset(9.0)
            $0.top.equalTo(fullLinkText.snp.bottom).inset(3.0)
        }
    }

    private func setUpViews() {

    }

}
