//
//  DependencyFactory+ViewModelFactoryProtocol.swift
//  ShortenLink
//
//  Created by Bliss on 29/07/2021.
//

extension DependencyFactory: ViewModelFactoryProtocol {

    func shortenLinkViewModel() -> ShortenLinkViewModelType {
        ShortenLinkViewModel(createShortenLinkUseCase: createShortenLinkUseCase())
    }

    func linksPopOverViewModel() -> LinksPopOverViewModelType {
        LinksPopOverViewModel(
            userUseCase: userUseCase(),
            getShortenLinkUseCase: getShortenLinksUseCase(),
            deleteShortenLinkUseCase: deleteShortenLinkUseCase()
        )
    }

    func loginViewModel() -> LoginViewModelType {
        LoginViewModel(gSignInUseCase: gSignInUseCase(), userUseCase: userUseCase())
    }

    func editLinkViewModel(link: EditingShortenLink) -> EditLinkViewModelType {
        EditLinkViewModel(link: link, editShortenLinkUseCase: editShortenLinkUseCase())
    }
}
