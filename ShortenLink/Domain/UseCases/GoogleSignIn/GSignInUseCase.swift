//
//  GSignInUseCase.swift
//  ShortenLink
//
//  Created by Su T. Nguyen on 22/11/2021.
//

import RxSwift
import AppAuth
import GTMAppAuth

// sourcery: AutoMockable
protocol GSignInUseCaseProtocol: AnyObject {

    func signIn() -> Single<String>
}

final class GSignInUseCase: NSObject, GSignInUseCaseProtocol {

    private let kIssuer = "https://accounts.google.com"
    private let kClientID = "659972231175-v1d19sfqfp25sr9a2sv629uioq1pu466.apps.googleusercontent.com"
    private let kClientSecret = "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"
    private let kRedirectURI = "com.googleusercontent.apps.659972231175-v1d19sfqfp25sr9a2sv629uioq1pu466:/oauthredirect"
    private let disposeBag = DisposeBag()

    func signIn() -> Single<String> {
        guard let issuerURL = URL(string: kIssuer),
              let redirectURL = URL(string: kRedirectURI)
        else { return .error(NetworkAPIError.generic) }
        return .create { observer in
            OIDAuthorizationService.discoverConfiguration(forIssuer: issuerURL) { [weak self] config, error in
                if let error = error {
                    observer(.failure(error))
                    return
                }
                guard let self = self, let config = config
                else {
                    observer(.failure(NetworkAPIError.generic))
                    return
                }
                let request = OIDAuthorizationRequest(
                    configuration: config,
                    clientId: self.kClientID,
                    clientSecret: self.kClientSecret,
                    scopes: [OIDScopeOpenID],
                    redirectURL: redirectURL,
                    responseType: OIDResponseTypeCode,
                    additionalParameters: nil
                )

                let appDelegate = NSApplication.shared.delegate as? AppDelegate

                appDelegate?.currentUserSession = OIDAuthState.authState(
                    byPresenting: request,
                    externalUserAgent: self
                ) { state, error in
                    if let error = error {
                        observer(.failure(error))
                        return
                    }
                    observer(.success(state?.lastTokenResponse?.idToken ?? ""))
                }
            }
            return Disposables.create()
        }
    }
}

// MARK: - OIDExternalUserAgent

extension GSignInUseCase: OIDExternalUserAgent {

    func present(_ request: OIDExternalUserAgentRequest, session: OIDExternalUserAgentSession) -> Bool {
        let config = NSWorkspace.OpenConfiguration()
        guard let url = request.externalUserAgentRequestURL() else { return false }
        NSWorkspace.shared.openApplication(at: url, configuration: config, completionHandler: nil)
        return true
    }

    func dismiss(animated: Bool, completion: @escaping () -> Void) {
        completion()
    }
}
