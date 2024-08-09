//
//  AuthenticatedViewModel.swift
//  MessengerApp
//
//  Created by 정성윤 on 8/6/24.
//

import Combine
import Foundation
import AuthenticationServices

enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticatedViewModel: ObservableObject {

    enum Action {
        case checkAuthenticationState
        case googleLogin
        case appleLogin(ASAuthorizationAppleIDRequest)
        case appleLoginCompletion(Result<ASAuthorization, Error>)
        case logout
    }

    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var isLoading = false

    var userId: String?

    private var currentNonce : String?
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()

    init(container: DIContainer) {
        self.container = container
    }

    func send(action: Action) {
        switch action {
            
        case .checkAuthenticationState:
            if let userId = container.service.authService.checkAuthenticationState() {
                self.userId = userId
                self.authenticationState = .authenticated
            }
            
        case .googleLogin:
            isLoading = true
            container.service.authService.signInWithGoogle()
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.isLoading = false
                    }
                } receiveValue: { [weak self] user in
                    self?.isLoading = false
                    self?.userId = user.id
                    self?.authenticationState = .authenticated
                }.store(in: &subscriptions)
            
        case let .appleLogin(request):
            let nonce = container.service.authService.handleSignInWithAppleRequest(request)
            self.currentNonce = nonce
            
        case let .appleLoginCompletion(result):
            if case let .success(authorization) = result {
                guard let nonce = currentNonce else { return }
                isLoading = true
                container.service.authService.handleSignInWithAppleCompletion(authorization, none: nonce)
                    .sink { completion in
                        if case .failure = completion {
                            self.isLoading = false
                        }
                    } receiveValue: { [weak self] user in
                        self?.isLoading = false
                        self?.userId = user.id
                    }.store(in: &subscriptions)
            } else if case let .failure(error) = result {
                print(error.localizedDescription)
            }
            
        case .logout:
            container.service.authService.logout()
                .sink { completion in
                    
                } receiveValue: { [weak self] _ in
                    self?.authenticationState = .unauthenticated
                    self?.userId = nil
                }.store(in: &subscriptions)
        }
    }
}
