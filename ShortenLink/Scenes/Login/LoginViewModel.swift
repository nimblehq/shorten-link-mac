//
//  LoginViewModel.swift
//  ShortenLink
//
//  Created by Phong Vo on 22/11/2021.
//

import Foundation

protocol LoginViewModelType {

    var input: LoginViewModelInput { get }
    var output: LoginViewModelOutput { get }
}

protocol LoginViewModelInput {

}

protocol LoginViewModelOutput {

}

final class LoginViewModel: LoginViewModelType,
                            LoginViewModelInput,
                            LoginViewModelOutput {

    var input: LoginViewModelInput { self }
    var output: LoginViewModelOutput { self }

    init() {
        
    }
}
