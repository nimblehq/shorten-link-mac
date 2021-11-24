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
    var shortenLinkViewModel: ShortenLinkViewModelType { get }
    var logInViewModel: LoginViewModelType { get }
}

protocol LinksPopOverViewModelInput {

    var viewWillAppear: PublishRelay<Void> { get }
    var logOutTapped: PublishRelay<Void> { get }

}

final class LinksPopOverViewModel: LinksPopOverViewModelType, LinksPopOverViewModelInput, LinksPopOverViewModelOutput {

    var input: LinksPopOverViewModelInput { self }
    var output: LinksPopOverViewModelOutput { self }

    // Input
    let viewWillAppear = PublishRelay<Void>()
    let logOutTapped = PublishRelay<Void>()

    // Output
    let shortenLinks: BehaviorRelay<[ShortenLinkCellViewModel]>
    let reloadList: Signal<Void>
    var shouldShowLogin: Signal<Bool>
    let shortenLinkViewModel: ShortenLinkViewModelType
    let logInViewModel: LoginViewModelType

    private let onLogout = PublishRelay<Void>()
    private let disposeBag = DisposeBag()

    init(userUseCase: UserUseCaseProtocol) {
        shortenLinkViewModel = DependencyFactory.shared.shortenLinkViewModel()
        logInViewModel = DependencyFactory.shared.loginViewModel()

        let dummyShortenLinks = [
            ShortenLinkCellViewModel(
                fullLink: "http://alonglink.com/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                shortenLink: "https://nimble.link/my-url-12345678",
                createdAt: Date()
            ),
            ShortenLinkCellViewModel(
                fullLink: "http://alonglink.com/bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
                shortenLink: "https://nimble.link/my-url-12345678",
                createdAt: Date().addingTimeInterval(TimeInterval(-60.0))
            ),
            ShortenLinkCellViewModel(
                fullLink: "http://alonglink.com/bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
                shortenLink: "https://nimble.link/my-url-12345678",
                createdAt: Date().addingTimeInterval(TimeInterval(-120.0))
            ),
            ShortenLinkCellViewModel(
                fullLink: "http://alonglink.com/cccccccccccccccccccccccccccccccccccccccc",
                shortenLink: "https://nimble.link/my-url-12345678",
                createdAt: Date().addingTimeInterval(TimeInterval(-3_600.0))
            )
        ]

        shortenLinks = BehaviorRelay<[ShortenLinkCellViewModel]>(value: dummyShortenLinks)

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

        logOutTapped
            .flatMapLatest { _ -> Observable<Void> in
                return .create { [weak self] observer in
                    guard let self = self else { return Disposables.create() }
                    userUseCase.logOut()
                        .subscribe(onCompleted: {
                            observer.onNext(())
                        })
                        .disposed(by: self.disposeBag)
                    return Disposables.create()
                }
            }
            .bind(to: onLogout)
            .disposed(by: disposeBag)
    }
}
