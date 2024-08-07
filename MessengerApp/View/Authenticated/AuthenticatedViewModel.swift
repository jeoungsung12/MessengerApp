//
//  AuthenticatedViewModel.swift
//  MessengerApp
//
//  Created by 정성윤 on 8/6/24.
//

import Foundation

enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticatedViewModel : ObservableObject {
    
    @Published var authenticationState : AuthenticationState = .unauthenticated
    
    private var container : DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
}
