//
//  ObservableType+Void.swift
//  ShortenLink
//
//  Created by Su T. Nguyen on 22/11/2021.
//

import RxSwift
import RxCocoa

extension ObservableType {

    func mapToVoid() -> Observable<Void> { map { _ in } }
}

extension SharedSequenceConvertibleType {

    func mapToVoid() -> SharedSequence<SharingStrategy, Void> { map { _ in } }
}

extension PrimitiveSequenceType where Trait == SingleTrait {

    func mapToVoid() -> PrimitiveSequence<Trait, Void> { map { _ in } }
}
