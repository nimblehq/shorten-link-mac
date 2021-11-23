//
//  LinksPopOverViewController.swift
//  ShortenLink
//
//  Created by Phong Vo on 17/11/2021.
//

import Cocoa
import SnapKit
import RxSwift
import RxCocoa

final class LinksPopOverViewController: NSViewController {

    private let titleField = NSTextField()
    private let settingButton = NSButton()
    private let tableView = NSTableView()
    private let scrollView = NSScrollView()
    private let topSeparator = NSBox()
    private let disposeBag = DisposeBag()
    private let viewModel: LinksPopOverViewModelType!

    weak private var shortenLinkView: NSView?
    weak private var moreOptionView: NSView?

    init(viewModel: LinksPopOverViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = NSView(frame: NSRect(x: 0.0, y: 0.0, width: 340.0, height: 370.0))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        setUpViews()
        bindOutput()
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        viewModel.input.viewWillAppear.accept(())
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        tableView.sizeToFit()
    }
}

extension LinksPopOverViewController {

    private func setUpLayout() {
        view.addSubviews(titleField, settingButton, scrollView, topSeparator)

        titleField.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalToSuperview().inset(8.0)
        }

        topSeparator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(1.0)
            $0.top.equalTo(titleField.snp.bottom).inset(-8.0)
        }

        settingButton.snp.makeConstraints {
            $0.centerY.equalTo(titleField)
            $0.trailing.equalToSuperview().inset(8.5)
            $0.size.equalTo(CGSize(width: 20.0, height: 20.0))
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(titleField.snp.bottom).inset(-10.0)
            $0.trailing.leading.bottom.equalToSuperview()
        }

        tableView.frame = scrollView.bounds

        insertMoreOptionViewController()
    }

    private func setUpViews() {
        titleField.backgroundColor = .clear
        titleField.stringValue = L10n.LinksPopOver.Titletext.title
        titleField.font = .systemFont(ofSize: 14.0)
        titleField.isEditable = false
        titleField.isBezeled = false

        topSeparator.boxType = .custom
        topSeparator.borderColor = .clear
        topSeparator.borderWidth = 0.0
        topSeparator.fillColor = NSColor.textColor.withAlphaComponent(0.3)

        settingButton.image = Asset.settingIc.image
        settingButton.bezelStyle = .shadowlessSquare
        settingButton.isBordered = false
        settingButton.imagePosition = .imageOnly

        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "column"))
        tableView.addTableColumn(column)
        tableView.headerView = nil
        tableView.delegate = self
        tableView.dataSource = self
        tableView.usesAutomaticRowHeights = true
        if #available(macOS 11.0, *) {
            tableView.style = .plain
        }
        tableView.enclosingScrollView?.borderType = .noBorder
        tableView.backgroundColor = .clear

        scrollView.documentView = tableView
        scrollView.backgroundColor = .clear
        scrollView.drawsBackground = false
        scrollView.hasHorizontalScroller = false
        scrollView.hasVerticalScroller = false
        scrollView.automaticallyAdjustsContentInsets = false

        addLoginController()
    }

    private func bindOutput() {
        viewModel.output.shortenLinks
            .asDriver()
            .drive(with: self, onNext: { owner, _ in
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)

        viewModel.output.reloadList
            .emit(with: self, onNext: { owner, _ in
                owner.tableView.reloadData()
            })
            .disposed(by: disposeBag)

        viewModel.output.isLoggedIn
            .drive(with: self, onNext: { owner, isLoggedIn in
                owner.scrollView.isHidden = !isLoggedIn
            })
            .disposed(by: disposeBag)
    }

    private func addLoginController() {
        let loginViewModel = DependencyFactory.shared.loginViewModel()
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        addChild(loginViewController)
        loginViewController.view.frame = view.frame
        view.addSubview(loginViewController.view)
    }

    private func layoutChildControllers() {
        let topAnchor = shortenLinkView?.snp.bottom ?? view.snp.top
        let bottomAnchor = moreOptionView?.snp.top ?? view.snp.bottom

        scrollView.snp.remakeConstraints {
            $0.top.equalTo(topAnchor)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalTo(bottomAnchor)
        }
    }
}

extension LinksPopOverViewController: NSTableViewDelegate {

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellViewModel = viewModel.output.shortenLinks.value[row]
        if let cell = tableView.makeView(
            withIdentifier: NSUserInterfaceItemIdentifier(rawValue: ShortenLinkCellView.identifier),
            owner: self
        ) as? ShortenLinkCellView {
            cell.configure(with: cellViewModel)
            return cell
        }
        let cell = ShortenLinkCellView()
        cell.identifier = NSUserInterfaceItemIdentifier(rawValue: ShortenLinkCellView.identifier)
        cell.configure(with: cellViewModel)
        return cell
    }

    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return CustomTableRowView()
    }
}

extension LinksPopOverViewController: NSTableViewDataSource {

    func numberOfRows(in tableView: NSTableView) -> Int {
        viewModel.output.shortenLinks.value.count
    }
}

extension LinksPopOverViewController {

    func insertShortenLinkViewController(_ viewController: ShortenLinkViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.snp.makeConstraints {
            $0.top.equalTo(titleField.snp.bottom).offset(8.0)
            $0.leading.trailing.equalToSuperview().inset(8.0)
            $0.height.equalTo(60.0)
        }
        shortenLinkView = viewController.view
        layoutChildControllers()
    }

    func insertMoreOptionViewController() {
        let viewController = MoreOptionViewController()
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
        moreOptionView = viewController.view
        layoutChildControllers()
    }
}
