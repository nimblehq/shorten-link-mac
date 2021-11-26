//
//  ShortenLinkViewModel.swift
//  ShortenLink
//
//  Created by Bliss on 22/11/21.
//

import Foundation
import RxCocoa
import RxSwift

protocol ShortenLinkViewModelType {

    var input: ShortenLinkViewModelInput { get }
    var output: ShortenLinkViewModelOutput { get }
}

protocol ShortenLinkViewModelOutput {

    var linkShortenSuccess: Driver<Bool> { get }
}

protocol ShortenLinkViewModelInput {

    func shortenLink(link: String)
}

final class ShortenLinkViewModel: ShortenLinkViewModelType {

    var linkShortenSuccess: Driver<Bool>

    var input: ShortenLinkViewModelInput { self }
    var output: ShortenLinkViewModelOutput { self }

    private var shortenLinkTrigger = PublishRelay<String>()
    private var createShortenLinkUseCase: CreateShortenLinkUseCaseProtocol

    init(createShortenLinkUseCase: CreateShortenLinkUseCaseProtocol) {
        self.createShortenLinkUseCase = createShortenLinkUseCase

        linkShortenSuccess = shortenLinkTrigger
            .flatMapLatest { input -> Driver<Bool> in
                createShortenLinkUseCase
                    .createLink(input, alias: nil, password: "")
                    .asObservable().materialize()
                    .filter { $0.element != nil }
                    .map {
                        let pasteboard = NSPasteboard.general
                        pasteboard.setGeneralString("\(Constants.API.shortenedLinkBaseURL)\($0.element?.alias ?? "")")
                        return true
                    }
                    .asDriver(onErrorJustReturn: false)
            }
            .asDriver(onErrorJustReturn: false)
    }
}

extension ShortenLinkViewModel: ShortenLinkViewModelInput {

    func shortenLink(link: String) {
        shortenLinkTrigger.accept(link)
    }
}

extension ShortenLinkViewModel: ShortenLinkViewModelOutput {
}
