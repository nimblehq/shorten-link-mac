//
//  LoginViewModel.swift
//  ShortenLink
//
//  Created by Phong Vo on 22/11/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol LoginViewModelType {

    var input: LoginViewModelInput { get }
    var output: LoginViewModelOutput { get }
}

protocol LoginViewModelInput {

    var logInWithGoogleTapped: PublishRelay<Void> { get }
}

protocol LoginViewModelOutput {

    var userDidLogin: Signal<Void> { get }
}

final class LoginViewModel: LoginViewModelType,
                            LoginViewModelInput,
                            LoginViewModelOutput {

    var input: LoginViewModelInput { self }
    var output: LoginViewModelOutput { self }

    // Input
    var logInWithGoogleTapped = PublishRelay<Void>()

    // Output
    var userDidLogin: Signal<Void>

    private let disposeBag = DisposeBag()
    private let _userDidLogin = PublishRelay<Void>()

    init(gSignInUseCase: GSignInUseCaseProtocol, userUseCase: UserUseCaseProtocol) {
        userDidLogin = _userDidLogin.asSignal(onErrorSignalWith: .empty())

        logInWithGoogleTapped
            .flatMapLatest(gSignInUseCase.signIn)
            .flatMapLatest(userUseCase.login)
            .mapToVoid()
            .subscribe(with: self, onCompleted: { owner in owner._userDidLogin.accept(()) })
            .disposed(by: disposeBag)
    }
}
