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

    private let fullLinkField = NSTextField()
    private let shortenLinkField = NSTextField()
    private let createdDateField = NSTextField()
    private let editLinkButton = NSButton()
    private let deleteLinkButton = NSButton()
    private var disposeBag = DisposeBag()
    private var viewModel: ShortenLinkCellViewModelType?

    static let identifier = "ShortenLinkCellView"

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
        viewModel = nil
        super.prepareForReuse()
    }

    func configure(with viewModel: ShortenLinkCellViewModelType) {
        self.viewModel = viewModel
        editLinkButton.rx.tap
            .bind(to: viewModel.input.editLinkTapped)
            .disposed(by: disposeBag)

        deleteLinkButton.rx.tap
            .subscribe { [weak self] _ in
                self?.showDeleteAlert()
            }
            .disposed(by: disposeBag)

        shortenLinkField.stringValue = viewModel.output.shortenLink
        fullLinkField.stringValue = viewModel.output.fullLink
        createdDateField.stringValue = viewModel.output.createdAt
    }
}

// MARK: - Private functions

extension ShortenLinkCellView {

    private func setUpLayout() {
        addSubviews(
            fullLinkField,
            shortenLinkField,
            createdDateField,
            editLinkButton,
            deleteLinkButton
        )

        deleteLinkButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10.0)
            $0.size.equalTo(CGSize(width: 18.0, height: 18.0))
            $0.centerY.equalToSuperview()
        }

        editLinkButton.snp.makeConstraints {
            $0.trailing.equalTo(deleteLinkButton.snp.leading).inset(-15.0)
            $0.size.equalTo(CGSize(width: 18.0, height: 18.0))
            $0.centerY.equalToSuperview()
        }

        shortenLinkField.snp.contentHuggingHorizontalPriority = 1_000
        shortenLinkField.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.lessThanOrEqualTo(editLinkButton.snp.leading).inset(-15.0)
            $0.top.equalToSuperview().inset(10.0)
        }

        fullLinkField.snp.makeConstraints {
            $0.leading.equalTo(shortenLinkField)
            $0.width.equalTo(shortenLinkField.snp.width)
            $0.top.equalTo(shortenLinkField.snp.bottom).inset(-3.0)
        }

        createdDateField.snp.makeConstraints {
            $0.leading.equalTo(shortenLinkField)
            $0.width.equalTo(shortenLinkField)
            $0.top.equalTo(fullLinkField.snp.bottom).inset(-3.0)
            $0.bottom.equalToSuperview().inset(9.0)
        }
    }

    private func setUpViews() {
        shortenLinkField.backgroundColor = .clear
        shortenLinkField.font = .systemFont(ofSize: 11.0)
        shortenLinkField.isEditable = false
        shortenLinkField.isBezeled = false
        shortenLinkField.lineBreakMode = .byTruncatingTail

        fullLinkField.backgroundColor = .clear
        fullLinkField.font = .systemFont(ofSize: 9.0)
        fullLinkField.isEditable = false
        fullLinkField.isBezeled = false
        fullLinkField.lineBreakMode = .byTruncatingTail

        createdDateField.backgroundColor = .clear
        createdDateField.font = .systemFont(ofSize: 9.0)
        createdDateField.isEditable = false
        createdDateField.isBezeled = false
        createdDateField.lineBreakMode = .byTruncatingTail

        deleteLinkButton.image = Asset.deleteIc.image
        deleteLinkButton.bezelStyle = .shadowlessSquare
        deleteLinkButton.isBordered = false
        deleteLinkButton.imagePosition = .imageOnly

        editLinkButton.image = Asset.editIc.image
        editLinkButton.bezelStyle = .shadowlessSquare
        editLinkButton.isBordered = false
        editLinkButton.imagePosition = .imageOnly
    }

    private func showDeleteAlert() {
        guard let window = self.window else { return }
        let alert = NSAlert()
        alert.icon = NSImage(named: NSImage.cautionName)
        alert.messageText = """
        "Are you sure to delete this Nimble Link “https://nimble-link/example-for-a-typing-alias-someID1234567890”?

        This action cannot be undone.
        """
        alert.addButton(withTitle: "Delete")
        alert.addButton(withTitle: "Cancel")
        alert.buttons[0].highlight(true)
        alert.alertStyle = .warning

        alert.beginSheetModal(for: window, completionHandler: { [weak self] modalResponse -> Void in
            if modalResponse == .alertFirstButtonReturn {
                print("Document deleted")
                self?.viewModel?.input.deleteLinkTapped.accept(())
            }
        })
    }
}
