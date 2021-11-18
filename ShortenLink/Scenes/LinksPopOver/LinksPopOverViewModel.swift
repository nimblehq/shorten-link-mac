//
//  LinksPopOverViewModel.swift
//  ShortenLink
//
//  Created by Phong Vo on 17/11/2021.
//

import Foundation

protocol LinksPopOverViewModelType {

    var input: LinksPopOverViewModelInput { get }
    var output: LinksPopOverViewModelOutput { get }
}

protocol LinksPopOverViewModelOutput {

}

protocol LinksPopOverViewModelInput {

}

final class LinksPopOverViewModel: LinksPopOverViewModelType, LinksPopOverViewModelInput, LinksPopOverViewModelOutput {

    var input: LinksPopOverViewModelInput { self }
    var output: LinksPopOverViewModelOutput { self }

    init() {

    }
}
