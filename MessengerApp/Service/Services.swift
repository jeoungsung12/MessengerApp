//
//  Services.swift
//  MessengerApp
//
//  Created by 정성윤 on 8/6/24.
//

import Foundation

protocol ServiceType {
    var authService : AuthenticationServiceType { get set }
}

class Services : ServiceType {
    var authService: AuthenticationServiceType
    
    init() {
        self.authService = AuthenticationService()
    }
}

class StubService: ServiceType {
    var authService: AuthenticationServiceType = StubAuthenticationService()
}
