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
}
