//
//  MoreOptionViewController.swift
//  ShortenLink
//
//  Created by Bliss on 24/11/21.
//

import AppKit

final class MoreOptionViewController: NSViewController {

    private let buttonStackView = NSStackView()
    private let moreButton = NSButton()
    private let bubbleButton = NSButton()
    private let lineView = NSView()

    override func loadView() {
        view = NSView(frame: NSRect(x: 0.0, y: 0.0, width: 340.0, height: 35.0))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        setUpViews()
    }
}

extension MoreOptionViewController {

    private func setUpLayout() {
        view.addSubviews(buttonStackView, lineView)
        buttonStackView.addArrangedSubview(bubbleButton)
        buttonStackView.addArrangedSubview(moreButton)

        lineView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(1.0)
        }

        buttonStackView.snp.makeConstraints {
            $0.trailing.bottom.top.equalToSuperview().inset(7.0)
            $0.leading.greaterThanOrEqualToSuperview()
        }
    }

    private func setUpViews() {
        buttonStackView.spacing = 8.0
        buttonStackView.orientation = .horizontal

        bubbleButton.imageOnly(image: Asset.about.image)
        bubbleButton.target = self

        moreButton.imageOnly(image: Asset.more.image)
        moreButton.target = self
        moreButton.action = #selector(tapMoreButton)

        lineView.wantsLayer = true
        lineView.layer?.backgroundColor = NSColor.textColor.withAlphaComponent(0.3).cgColor
    }

    private func showQuitMenu(_ view: NSView) {
        let menu = NSMenu()
        let signOutItem = NSMenuItem(
            title: L10n.Option.SignOutMenu.title,
            action: #selector(tapSignOut),
            keyEquivalent: ""
        )

        let quitItem = NSMenuItem(
            title: L10n.Option.QuitMenu.title,
            action: #selector(tapQuit),
            keyEquivalent: ""
        )

        signOutItem.target = self
        quitItem.target = self

        menu.addItem(signOutItem)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(quitItem)

        menu.popUp(
            positioning: signOutItem,
            at: view.frame.origin,
            in: view
        )
    }

    @objc func tapMoreButton(_ sender: Any?) {
        showQuitMenu(sender as? NSView ?? view)
    }

    @objc func tapSignOut(_ sender: Any?) {

    }

    @objc func tapQuit(_ sender: Any?) {
        NSApplication.shared.terminate(self)
    }
}
