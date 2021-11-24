//
//  ViewModelFactoryProtocol.swift
//  ShortenLink
//
//  Created by Bliss on 27/07/2021.
//

protocol ViewModelFactoryProtocol {

    func shortenLinkViewModel() -> ShortenLinkViewModelType
    func linksPopOverViewModel() -> LinksPopOverViewModelType
    func loginViewModel() -> LoginViewModelType
}
