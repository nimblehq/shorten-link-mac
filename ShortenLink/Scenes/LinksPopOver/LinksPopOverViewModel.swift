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
}

protocol LinksPopOverViewModelInput {

    var viewWillAppear: PublishRelay<Void> { get }
    var settingButtonTapped: PublishRelay<Void> { get }
}

final class LinksPopOverViewModel: LinksPopOverViewModelType, LinksPopOverViewModelInput, LinksPopOverViewModelOutput {

    var input: LinksPopOverViewModelInput { self }
    var output: LinksPopOverViewModelOutput { self }

    // Input
    let viewWillAppear = PublishRelay<Void>()
    let settingButtonTapped = PublishRelay<Void>()

    // Output
    let shortenLinks: BehaviorRelay<[ShortenLinkCellViewModel]>
    let reloadList: Signal<Void>

    private let disposeBag = DisposeBag()

    init(
        gSignInUseCase: GSignInUseCaseProtocol,
        userUsecase: UserUseCaseProtocol
    ) {
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

        settingButtonTapped
            .flatMap(gSignInUseCase.signIn)
            .flatMap(userUsecase.login)
            .subscribe()
            .disposed(by: disposeBag)
    }
}
