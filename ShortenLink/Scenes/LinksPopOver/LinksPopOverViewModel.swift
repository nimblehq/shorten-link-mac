//
//  LinksPopOverViewModel.swift
//  ShortenLink
//
//  Created by Phong Vo on 17/11/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol LinksPopOverViewModelType {

    var input: LinksPopOverViewModelInput { get }
    var output: LinksPopOverViewModelOutput { get }
}

protocol LinksPopOverViewModelOutput {

    var shortenLinks: BehaviorRelay<[ShortenLinkCellViewModel]> { get }
    var reloadList: Signal<Void> { get }

    var shouldShowLogin: Signal<Bool> { get }
    var editViewModel: BehaviorRelay<EditLinkViewModelType?> { get }
    var shortenLinkViewModel: ShortenLinkViewModelType { get }
    var logInViewModel: LoginViewModelType { get }
    var didCopyLink: Signal<Void> { get }
}

protocol LinksPopOverViewModelInput {

    var viewWillAppear: PublishRelay<Void> { get }
    var logOutTapped: PublishRelay<Void> { get }
    var copyLink: PublishRelay<String> { get }

}

final class LinksPopOverViewModel: LinksPopOverViewModelType, LinksPopOverViewModelInput, LinksPopOverViewModelOutput {

    var input: LinksPopOverViewModelInput { self }
    var output: LinksPopOverViewModelOutput { self }

    // Input
    let viewWillAppear = PublishRelay<Void>()
    let logOutTapped = PublishRelay<Void>()
    let copyLink = PublishRelay<String>()
    
    // Output
    let shortenLinks: BehaviorRelay<[ShortenLinkCellViewModel]>
    let reloadList: Signal<Void>
    var shouldShowLogin: Signal<Bool>
    let editViewModel: BehaviorRelay<EditLinkViewModelType?>
    let shortenLinkViewModel: ShortenLinkViewModelType
    let logInViewModel: LoginViewModelType
    var didCopyLink: Signal<Void>

    private let onLogout = PublishRelay<Void>()
    private let disposeBag = DisposeBag()

    init(
        userUseCase: UserUseCaseProtocol,
        getShortenLinkUseCase: GetShortenLinkUseCaseProtocol,
        deleteShortenLinkUseCase: DeleteShortenLinkUseCaseProtocol
    ) {
        shortenLinkViewModel = DependencyFactory.shared.shortenLinkViewModel()
        logInViewModel = DependencyFactory.shared.loginViewModel()

        shortenLinks = BehaviorRelay<[ShortenLinkCellViewModel]>(value: [])
        editViewModel = BehaviorRelay<EditLinkViewModelType?>(value: nil)

        reloadList = viewWillAppear
            .skip(1) // skip 1st
            .asSignal(onErrorSignalWith: .empty())

        shouldShowLogin = Observable
            .merge(
                viewWillAppear.asObservable(),
                onLogout.asObservable()
            )
            .flatMap { userUseCase.checkUserLoggedIn() }
            .distinctUntilChanged()
            .map { !$0 }
            .asSignal(onErrorSignalWith: .empty())

        didCopyLink = copyLink
            .map { value in
                let pasteboard = NSPasteboard.general
                pasteboard.setGeneralString(value)
                return
            }
            .asSignal(onErrorSignalWith: .empty())

        logOutTapped
            .flatMapLatest { _ -> Observable<Void> in
                .create { [weak self] observer in
                    guard let self = self else { return Disposables.create() }
                    userUseCase.logOut()
                        .subscribe { _ in
                            observer.onNext(())
                        }
                        .disposed(by: self.disposeBag)
                    return Disposables.create()
                }
            }
            .flatMapLatest { _ -> Observable<Void> in
                .create { [weak self] observer in
                    guard let self = self else { return Disposables.create() }
                    userUseCase.clearUserSession()
                        .subscribe { _ in
                            observer.onNext(())
                        }
                        .disposed(by: self.disposeBag)
                    return Disposables.create()
                }
            }
            .bind(to: onLogout)
            .disposed(by: disposeBag)

        shortenLinkViewModel
            .output
            .linkShortenSuccess
            .drive(onNext: { value in
                guard value else { return }
                self.viewWillAppear.accept(())
            })
            .disposed(by: disposeBag)

        viewWillAppear
            .flatMapLatest { [weak self] in
                getShortenLinkUseCase
                    .getLinks()
                    .asObservable()
                    .materialize()
                    .filter { $0.element != nil }
                    .map {
                        ($0.element ?? [])
                            .sorted(by: {
                                guard let lhsDate = $0.createdAtDate,
                                      let rhsDate = $1.createdAtDate
                                else { return false }
                                return lhsDate > rhsDate
                            })
                            .map {
                                let viewModel = ShortenLinkCellViewModel(
                                    id: $0.id,
                                    fullLink: $0.originalUrl,
                                    shortenLink: "\(Constants.API.shortenedLinkBaseURL)\($0.alias)",
                                    createdAt: $0.createdAtDate ?? Date()
                                )
                                guard let self = self else { return viewModel }
                                viewModel
                                    .input
                                    .deleteLinkTapped
                                    .subscribe(
                                        with: self,
                                        onNext: { owner, _ in
                                            deleteShortenLinkUseCase
                                                .deleteLink(viewModel.output.id)
                                                .subscribe {
                                                    owner.viewWillAppear.accept(())
                                                } onFailure: {
                                                    // TODO: Show Error when delete
                                                    print($0)
                                                }
                                                .disposed(by: owner.disposeBag)
                                        })
                                    .disposed(by: self.disposeBag)

                                viewModel
                                    .input
                                    .editLinkTapped
                                    .subscribe(
                                        with: self,
                                        onNext: { owner, _ in
                                            let viewModel = DependencyFactory.shared.editLinkViewModel(
                                                link: EditingShortenLink(
                                                    id: viewModel.output.id,
                                                    originalUrl: viewModel.output.fullLink
                                                )
                                            )
                                            viewModel.output.editLinkShortenSuccess.drive(onNext: {
                                                value in
                                                guard let link = value else { return }
                                                owner.viewWillAppear.accept(())
                                                owner.copyLink.accept(link)
                                            })
                                                .disposed(by: owner.disposeBag)
                                            owner.editViewModel.accept(viewModel)
                                        })
                                    .disposed(by: self.disposeBag)
                                return viewModel
                            }
                    }
            }
            .subscribe(with: self, onNext: { owner, event in
                owner.shortenLinks.accept(event)
            })
            .disposed(by: disposeBag)
    }
}
