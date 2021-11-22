//
//  UseCaseFactoryProtocol.swift
//  ShortenLink
//
//  Created by Bliss on 15/06/2021.
//

protocol UseCaseFactoryProtocol: AnyObject {

    func createShortenLinkUseCase() -> CreateShortenLinkUseCaseProtocol
    func userUseCase() -> UserUseCaseProtocol
}
