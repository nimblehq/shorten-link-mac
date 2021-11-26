//
//  EditLinkViewModel.swift
//  ShortenLink
//
//  Created by Bliss on 26/11/21.
//

import Foundation
import RxCocoa
import RxSwift

protocol EditLinkViewModelType {

    var input: EditLinkViewModelInput { get }
    var output: EditLinkViewModelOutput { get }
}

protocol EditLinkViewModelOutput {

    var editLinkShortenSuccess: Driver<String?> { get }
    var linkFullURL: Driver<String> { get }
    var shouldEnableSaveButton: Driver<Bool> { get }
}

protocol EditLinkViewModelInput {

    var aliasText: BehaviorRelay<String?> { get }
    var passwordText: BehaviorRelay<String?> { get }
    var isPasswordOn: BehaviorRelay<NSControl.StateValue> { get }
    var editShortLink: PublishRelay<Void> { get }
}

final class EditLinkViewModel: EditLinkViewModelType {

    // input
    var aliasText = BehaviorRelay<String?>(value: nil)
    var passwordText = BehaviorRelay<String?>(value: nil)
    var isPasswordOn = BehaviorRelay<NSControl.StateValue>(value: .off)
    var editShortLink = PublishRelay<Void>()

    // output
    var editLinkShortenSuccess: Driver<String?>
    var linkFullURL: Driver<String>
    var shouldEnableSaveButton: Driver<Bool>

    var input: EditLinkViewModelInput { self }
    var output: EditLinkViewModelOutput { self }

    private var editShortenLinkUseCase: EditShortenLinkUseCaseProtocol

    private let link: EditingShortenLink

    init(link: EditingShortenLink, editShortenLinkUseCase: EditShortenLinkUseCaseProtocol) {
        self.editShortenLinkUseCase = editShortenLinkUseCase
        self.link = link

        editLinkShortenSuccess = editShortLink
            .withLatestFrom(Observable.combineLatest(aliasText, passwordText, isPasswordOn))
            .flatMapLatest { (alias, password, isPassword) -> Driver<String?> in
                guard alias.string.count > 0,
                      (!(isPassword == .on) || password.string.count > 0)
                else { return Driver.just(nil) }
                let apiPassword = (isPassword == .on) ? password.string : ""
                return editShortenLinkUseCase
                    .editLink(link.id, alias: alias.string, password: apiPassword)
                    .asObservable()
                    .materialize()
                    .filter { $0.isCompleted }
                    .map { _ in "\(Constants.API.shortenedLinkBaseURL)\(alias.string)" }
                    .asDriver(onErrorJustReturn: nil)
            }
            .asDriver(onErrorJustReturn: nil)

        shouldEnableSaveButton = Observable.combineLatest(aliasText, passwordText, isPasswordOn)
            .flatMapLatest { (alias, password, isPassword) -> Driver<Bool> in
                let hasAlias = alias.string.count > 0
                let correctPassword = (isPassword == .on) ? password.string.count > 0 : true
                return Driver.just(correctPassword && hasAlias)
            }
            .asDriver(onErrorJustReturn: false)

        linkFullURL = Driver.just(link.originalUrl)
    }
}

extension EditLinkViewModel: EditLinkViewModelInput {
}

extension EditLinkViewModel: EditLinkViewModelOutput {
}
