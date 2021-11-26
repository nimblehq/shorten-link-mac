//
//  Optional+Default.swift
//  ShortenLink
//
//  Created by Bliss on 26/11/21.
//

import Foundation

extension Optional where Wrapped == String {

    var string: String { self ?? "" }
}
