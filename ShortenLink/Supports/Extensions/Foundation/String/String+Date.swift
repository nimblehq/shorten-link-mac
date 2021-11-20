//
//  String+Date.swift
//  ShortenLink
//
//  Created by Bliss on 18/11/21.
//

import Foundation

extension String {

    func asDate(using formatter: DateFormatter) -> Date? {
        return formatter.date(from: self)
    }
}
