//
//  LinksPopOverViewController.swift
//  ShortenLink
//
//  Created by Phong Vo on 17/11/2021.
//

import Cocoa
import SnapKit

final class LinksPopOverViewController: NSViewController {

    private let titleField = NSTextField()
    private let settingButton = NSButton()
    private let viewModel: LinksPopOverViewModelType!

    init(viewModel: LinksPopOverViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = NSView(frame: NSRect(x: 0.0, y: 0.0, width: 340.0, height: 370.0))
      }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        setUpViews()
    }
}

extension LinksPopOverViewController {

    private func setUpLayout() {
        view.addSubviews(titleField, settingButton)

        titleField.translatesAutoresizingMaskIntoConstraints = false
        settingButton.translatesAutoresizingMaskIntoConstraints = false

        titleField.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalToSuperview().inset(8.0)
        }

        settingButton.snp.makeConstraints {
            $0.centerY.equalTo(titleField)
            $0.trailing.equalToSuperview().inset(8.5)
            $0.size.equalTo(CGSize(width: 20.0, height: 20.0))
        }
    }

    private func setUpViews() {
        titleField.backgroundColor = .clear
        titleField.stringValue = L10n.LinksPopOver.Titletext.title
        titleField.font = .systemFont(ofSize: 14.0)
        titleField.isEditable = false
        titleField.isBezeled = false

        settingButton.image = Asset.settingIc.image
        settingButton.bezelStyle = .shadowlessSquare
        settingButton.isBordered = false
        settingButton.imagePosition = .imageOnly
    }
}
