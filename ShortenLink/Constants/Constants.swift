//
//  Constants.swift
//  ShortenLink
//
//  Created by Su T. Nguyen on 21/11/2021.
//

import Foundation

enum Constants {

    enum API { }
    enum Google { }
}

extension Constants.API {

    static let baseURL: String = "https://nimble-link.herokuapp.com/"
    static let shortenedLinkBaseURL: String = "https://l.nimblehq.co/"
}

extension Constants.Google {

    static let clientId: String = "659972231175-tsph0d8ucfnntotncki6nle4jqks1t6a.apps.googleusercontent.com"
}
